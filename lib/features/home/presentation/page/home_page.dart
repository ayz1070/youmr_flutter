import 'package:flutter/material.dart';
import 'package:youmr_flutter/core/constants/app_config.dart';
import 'package:youmr_flutter/features/sign_up/data/data_source/member_remote_data_source.dart';
import 'package:youmr_flutter/features/sign_up/data/repository_impl/member_repository_impl.dart';

import '../../../sign_up/domain/entity/member_entity.dart';
import '../../../sign_up/domain/repository/member_repository.dart';

class HomePage extends StatelessWidget {
  final int memberId = 1;
  final MemberRepository memberRepository = MemberRepositoryImpl(dataSource: MemberRemoteDataSource(baseUrl: AppConfig.baseUrl));

  HomePage({
    Key? key,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: FutureBuilder<MemberEntity>(
        future: memberRepository.fetchMember(memberId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('에러 발생: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('회원 정보를 찾을 수 없습니다.'));
          }

          final member = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(member.profileImage),
                ),
                const SizedBox(height: 20),
                Text('이름: ${member.name}', style: const TextStyle(fontSize: 20)),
                const SizedBox(height: 8),
                Text('닉네임: ${member.nickname}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 8),
                Text('회원번호: ${member.id}', style: const TextStyle(fontSize: 16)),
              ],
            ),
          );
        },
      ),
    );
  }
}