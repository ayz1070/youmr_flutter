import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../sign_up/domain/entity/member_entity.dart';

class MemberNotifier extends StateNotifier<MemberEntity?> {
  MemberNotifier() : super(null);

  void setMember(MemberEntity member) {
    state = member;
  }

  void updateNickname(String nickname) {
    if (state == null) return;
    state = state!.copyWith(nickname: nickname);
  }

  void updateProfileImage(String imageUrl) {
    if (state == null) return;
    state = state!.copyWith(profileImage: imageUrl);
  }

  void clear() {
    state = null;
  }
}

final memberProvider = StateNotifierProvider<MemberNotifier, MemberEntity?>(
      (ref) => MemberNotifier(),
);
