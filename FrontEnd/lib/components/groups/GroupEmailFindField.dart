import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import '../../entities/Member.dart';
import 'package:front/repository/api/ApiGroup.dart';

class GroupEmailFindField extends StatefulWidget {
  final TextEditingController controller;
  final groupId;
  final members;
  final Function(List<String>) onInvite;

  const GroupEmailFindField({
    Key? key,
    required this.controller,
    required this.groupId,
    required this.members,
    required this.onInvite,
  }) : super(key: key);

  @override
  _GroupEmailFindFieldState createState() => _GroupEmailFindFieldState();
}

class _GroupEmailFindFieldState extends State<GroupEmailFindField> {
  final _formKey = GlobalKey<FormState>();
  Member? _searchResult;
  List<String> inviteMember = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: '이메일 입력',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      final response =
                          await getMemberByEmail(widget.controller.text);
                      if (response != null) {
                        setState(() {
                          _searchResult = Member.fromJson(response.data);
                          if (_searchResult != null &&
                              _searchResult!.kakaoId != null) {
                            // 그룹 내에 이미 참가된 멤버인지 확인
                            bool isAlreadyMember = widget.members.any(
                                (member) =>
                                    member.kakaoId == _searchResult!.kakaoId);
                            // inviteMember 리스트 내에 이미 존재하는지 확인
                            bool isAlreadyInvited =
                                inviteMember.contains(_searchResult!.kakaoId);

                            // 그룹 내에 있는 멤버일 경우 제외
                            if (isAlreadyMember) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("이미 참가한 멤버입니다",
                                        style: TextStyle(color: Colors.red))),
                              );
                              widget.controller.clear();
                            } else if (isAlreadyInvited) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("이미 추가한 멤버입니다",
                                        style: TextStyle(color: Colors.red))),
                              );
                              widget.controller.clear();
                            } else {
                              inviteMember.add(_searchResult!.kakaoId!);
                              widget.controller.clear();
                            }
                          }
                        });
                      } else {
                        setState(() {
                          _searchResult = null;
                        });
                      }
                    } catch (e) {
                      print("멤버 검색 중 오류 발생: $e");
                      setState(() {
                        _searchResult = null;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text("검색된 사람이 없습니다",
                                  style: TextStyle(color: Colors.red))),
                        );
                      });
                    }
                  }
                },
              ),
            ),
            validator: (value) {
              if (value == null ||
                  value.isEmpty ||
                  !EmailValidator.validate(value)) {
                return '유효한 이메일을 입력해주세요.';
              }
              return null;
            },
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: TextButton(
            child: Text('초대하기'),
            onPressed: () {
              widget
                  .onInvite(inviteMember);
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
