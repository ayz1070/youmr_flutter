import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/attendance_module.dart';

class AttendancePage extends ConsumerStatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  ConsumerState<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends ConsumerState<AttendancePage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(attendanceViewModelProvider.notifier).fetchAttendances();
    });
  }

  String _getTodayWeekday() {
    final now = DateTime.now();
    const weekdays = ['월요일', '화요일', '수요일', '목요일', '금요일', '토요일', '일요일'];
    return weekdays[now.weekday - 1];
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(attendanceViewModelProvider);
    final viewModel = ref.read(attendanceViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 64),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${_getTodayWeekday()} 출첵',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),

          Expanded(
            child: Center(
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child:
                    state.attendees.isEmpty
                        ? const Center(
                          child: Text(
                            '아직 출석한 사람이 없습니다.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        )
                        : AnimatedList(
                          key: _listKey,
                          scrollDirection: Axis.horizontal,
                          initialItemCount: state.attendees.length,
                          itemBuilder: (context, index, animation) {
                            final attendee = state.attendees[index];
                            return SizeTransition(
                              sizeFactor: animation,
                              axis: Axis.vertical,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                ),
                                child: _buildAttendeeItem(attendee),
                              ),
                            );
                          },
                        ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final newAttendee = await viewModel.attend();
                      final newIndex = state.attendees.length;
                      state.attendees.add(newAttendee);
                      _listKey.currentState?.insertItem(newIndex);
                    },
                    icon: const Icon(Icons.check_circle_outline),
                    label: const Text('출석하기', style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      if (state.attendees.isNotEmpty) {
                        await viewModel.cancelAttend();
                        final removedIndex = state.attendees.length - 1;
                        _listKey.currentState?.removeItem(
                          removedIndex,
                          (context, animation) => _buildAnimatedItem(
                            state.attendees[removedIndex],
                            animation,
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.cancel_outlined),
                    label: const Text('취소하기', style: TextStyle(fontSize: 16)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.redAccent,
                      side: const BorderSide(color: Colors.redAccent),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedItem(
    Map<String, String> attendee,
    Animation<double> animation,
  ) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.1),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.easeInOut)),
        child: _buildAttendeeItem(attendee),
      ),
    );
  }

  Widget _buildAttendeeItem(Map<String, String?> attendee) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(attendee['profileImageUrl'] ?? ''),
          ),
          const SizedBox(height: 8),
          Text(
            attendee['name'] ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
