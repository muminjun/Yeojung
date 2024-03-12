package com.orange.fintech.transaction.entity;

import com.orange.fintech.member.entity.Member;
import jakarta.persistence.Embeddable;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.*;

import java.io.Serializable;

@Embeddable
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class ReceiptDetailMemberPK implements Serializable {

    @ManyToOne
    @JoinColumn(name = "receipt_detail_id")
    private ReceiptDetail receiptDetail;

    @ManyToOne
    @JoinColumn(name = "member_id")
    private Member member;
}
