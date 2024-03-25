package com.orange.fintech.account.service;

import com.orange.fintech.account.dto.AccountResDto;
import com.orange.fintech.account.dto.ReqHeader;
import com.orange.fintech.account.entity.Account;
import com.orange.fintech.member.entity.Member;
import com.orange.fintech.member.repository.AccountRepository;
import com.orange.fintech.member.repository.MemberRepository;
import com.orange.fintech.member.service.MemberService;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

@Service
@Slf4j
public class AccountServiceImpl implements AccountService {
    @Autowired AccountRepository accountRepository;
    @Autowired MemberRepository memberRepository;

    @Autowired MemberService memberService;

    @Value("${ssafy.bank.search.accounts}")
    private String searchAccountsUrl;

    @Value("${ssafy.bank.api-key}")
    private String apiKey;

    @Override
    public boolean insertAccount(String kakaoId, Account account) {
        Member member = memberService.findByKakaoId(kakaoId);
        account.setMember(member);

        try {
            accountRepository.save(account);

            return true;
        } catch (Exception e) {
            e.printStackTrace();

            return false;
        }
    }

    @Override
    public void updatePrimaryAccount(String kakaoId, String accountNo) {
        Member member = memberService.findByKakaoId(kakaoId);

        // 1. 기존 주 거래 계좌의 is_primary_account 값 false로 업데이트
        Account currentPrimaryAccount = accountRepository.findPrimaryAccountByKakaoId(member);
        currentPrimaryAccount.setIsPrimaryAccount(false);
        accountRepository.save(currentPrimaryAccount);

        // 2. 전달받은 계좌 번호의 is_primary_account 값 true로 업데이트
        Account newPrimaryAccount = accountRepository.findByAccountNo(accountNo);
        newPrimaryAccount.setIsPrimaryAccount(true);
        accountRepository.save(newPrimaryAccount);
    }

    @Override
    public List<AccountResDto> findAccountList(String memberId) {
        String apinameAndApiServiceCode = getApinameAndApiServiceCode(searchAccountsUrl);

        Member member = memberRepository.findById(memberId).get();
        String userKey = member.getUserKey();

        ReqHeader reqHeader = new ReqHeader();
        reqHeader.setApiKey(apiKey);
        reqHeader.setUserKey(userKey);
        reqHeader.setApiName(apinameAndApiServiceCode);
        reqHeader.setApiServiceCode(apinameAndApiServiceCode);
        RestClient.ResponseSpec response = null;
        RestClient restClient = RestClient.create();
        Map<String, Object> req = new HashMap<>();
        req.put("Header", reqHeader);

        response = restClient.post().uri(searchAccountsUrl).body(req).retrieve();
        log.info(response.body(String.class));

        log.info(reqHeader.toString());

        return null;
    }

    @Override
    public String getApinameAndApiServiceCode(String url) {
        String[] tmp = url.split("/");
        String result = tmp[tmp.length - 1];
        return result;
    }
}
