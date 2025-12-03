import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:family_invitation/utils/calendar/calendar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map_web/flutter_naver_map_web.dart';

class InfoSection extends StatelessWidget {
  const InfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        _buildDivider(),
        const SizedBox(height: 60),
        const CalendarSection(),
        const SizedBox(height: 60),
        _buildDivider(),
        const SizedBox(height: 60),
        const LocationSection(),
        const SizedBox(height: 60),
        _buildDivider(),
        const SizedBox(height: 60),
        const QnASection(),
        const SizedBox(height: 40),
        const ProfileButtonsSection(),
        const SizedBox(height: 60),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(width: 50, height: 1, color: const Color(0xFFE6E0D9));
  }
}

class CalendarSection extends StatelessWidget {
  const CalendarSection({super.key});

  Future<void> _addToCalendar() async {
    if (kIsWeb) {
      const String icsContent =
          'BEGIN:VCALENDAR\n'
          'VERSION:2.0\n'
          'PRODID:-//Family Invitation//KR\n'
          'BEGIN:VEVENT\n'
          'UID:family-invitation-20260110\n'
          'DTSTAMP:20251128T000000\n'
          'DTSTART:20260110T120000\n'
          'DTEND:20260110T140000\n'
          'SUMMARY:가족 식사\n'
          'DESCRIPTION:소중한 가족분들과의 식사 자리입니다.\n'
          'LOCATION:일품진진수라 광화문점\n'
          'END:VEVENT\n'
          'END:VCALENDAR';

      downloadIcsFile(icsContent);
    } else {
      final Event event = Event(
        title: '가족 식사',
        description: '소중한 가족분들과의 식사 자리입니다.',
        location: '일품진진수라 광화문점',
        startDate: DateTime(2026, 1, 10, 12, 0),
        endDate: DateTime(2026, 1, 10, 14, 0),
        iosParams: const IOSParams(reminder: Duration(minutes: 60)),
        androidParams: const AndroidParams(emailInvites: []),
      );
      Add2Calendar.addEvent2Cal(event);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'DATE',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 2,
            color: Color(0xFFBDBDBD),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '2026년 1월 10일 토요일 12시',
          style: TextStyle(
            fontFamily: 'MemomentKkukkukk',
            fontSize: 24,
            color: Color(0xFF5D5D5D),
          ),
        ),
        const SizedBox(height: 32),
        GestureDetector(
          onTap: _addToCalendar,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                _buildCalendarHeader(),
                const SizedBox(height: 16),
                _buildCalendarGrid(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        TextButton.icon(
          onPressed: _addToCalendar,
          icon: const Icon(
            Icons.calendar_today_outlined,
            size: 16,
            color: Color(0xFF8E8E8E),
          ),
          label: const Text(
            '캘린더에 일정 추가하기',
            style: TextStyle(color: Color(0xFF8E8E8E), fontSize: 13),
          ),
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFFF5F5F5),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    const days = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: days
          .map(
            (day) => SizedBox(
              width: 30,
              child: Text(
                day,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: day == 'SUN'
                      ? const Color(0xFFE57373)
                      : const Color(0xFFBDBDBD),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildCalendarGrid() {
    // January 2026
    // 1st is Thursday
    final days = [
      ['', '', '', '', '1', '2', '3'],
      ['4', '5', '6', '7', '8', '9', '10'],
      ['11', '12', '13', '14', '15', '16', '17'],
      ['18', '19', '20', '21', '22', '23', '24'],
      ['25', '26', '27', '28', '29', '30', '31'],
    ];

    return Column(
      children: days.map((week) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: week.asMap().entries.map((entry) {
              final int idx = entry.key;
              final String day = entry.value;
              final bool isTarget = day == '10';
              final bool isSunday = idx == 0;

              if (day.isEmpty) return const SizedBox(width: 30);

              return SizedBox(
                width: 30,
                height: 30,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    if (isTarget)
                      const Positioned(
                        top: -5,
                        child: Icon(
                          Icons.favorite,
                          color: Color(0xFFFFC0CB),
                          size: 40,
                        ),
                      ),
                    Text(
                      day,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isTarget
                            ? const Color(0xFF7B1FA2)
                            : (isSunday
                                  ? const Color(0xFFE57373)
                                  : const Color(0xFF424242)),
                        fontWeight: isTarget
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 13,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}

class LocationSection extends StatelessWidget {
  const LocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'LOCATION',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 2,
            color: Color(0xFFBDBDBD),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '일품진진수라 광화문점',
          style: TextStyle(
            fontFamily: 'MemomentKkukkukk',
            fontSize: 22,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          '서울 종로구 종로5길 7 Tower 8 지하 2층',
          style: TextStyle(fontSize: 14, color: Color(0xFF757575)),
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 200,
          child: NaverMapWeb(
            clientId: 's65fanh83m',
            initialLatitude: 37.570629,
            initialLongitude: 126.980532,
            initialZoom: 17,
            places: [
              Place(
                id: '1',
                name: '일품진진수라 광화문점',
                latitude: 37.570629,
                longitude: 126.980532,
                description: '일품진진수라 광화문점',
              ),
            ],
            onMapReady: (NaverMap map) {
              map.setZoom(17);
            },
          ),
        ),
      ],
    );
  }
}

class QnASection extends StatelessWidget {
  const QnASection({super.key});

  @override
  Widget build(BuildContext context) {
    final qnaList = [
      (q: '어떻게 만나게 되었나요?', a: '소개팅으로 만나게 되었어요.'),
      (q: '어디서 살기로 했나요?', a: '채은이 직장이 있는 영종도에서 살기로 했어요.'),
      (q: '언제부터 같이 사나요?', a: '26년 2월 말부터 같이 살아요.'),
      (q: '결혼식은 왜 안 하나요?', a: '채은이가 하고 싶지 않아했고 종우가 존중해줬어요.'),
      (q: '웨딩 사진은 찍나요?', a: '신혼여행 가서 스냅 사진을 찍을 계획이에요.'),
      (q: '신혼여행은 언제 어디로 가나요?', a: '26년 9월 말에 캐나다로 갈거예요.'),
    ];

    return Column(
      children: [
        const Text(
          'Q&A',
          style: TextStyle(
            fontSize: 12,
            letterSpacing: 2,
            color: Color(0xFFBDBDBD),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          '궁금증을 풀어드려요.',
          style: TextStyle(
            fontFamily: 'MemomentKkukkukk',
            fontSize: 22,
            color: Color(0xFF333333),
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: qnaList
                .map((item) => _buildQnAItem(item.q, item.a))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildQnAItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Q.',
                style: TextStyle(
                  color: Color(0xFFE57373),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF424242),
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'A.',
                style: TextStyle(
                  color: Color(0xFF9E9E9E),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  answer,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF616161),
                    height: 1.6,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProfileButtonsSection extends StatelessWidget {
  const ProfileButtonsSection({super.key});

  void _showProfile(
    BuildContext context,
    String name,
    String imagePath,
    Map<String, String> info,
  ) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          width: 280,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 180,
                width: double.infinity,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                child: Column(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontFamily: 'MemomentKkukkukk',
                        fontSize: 22,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...info.entries.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                e.key,
                                style: const TextStyle(
                                  color: Color(0xFF9E9E9E),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                e.value,
                                style: const TextStyle(
                                  color: Color(0xFF424242),
                                  fontSize: 13,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        backgroundColor: const Color(0xFFF5F5F5),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        '닫기',
                        style: TextStyle(
                          color: Color(0xFF616161),
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: _buildButton(
              context,
              '종우에 대해\n알아보기',
              () => _showProfile(context, '한종우', 'public/assets/jongwoo.jpg', {
                '출생년도': '1998',
                '고향': '서울',
                'MBTI': 'ISTJ',
                '학력': '서울대학교 컴퓨터공학부 학사, 석사',
                '직업': '자율주행 소프트웨어 개발자',
              }),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildButton(
              context,
              '채은이에 대해\n알아보기',
              () => _showProfile(context, '한채은', 'public/assets/chaeeun.jpg', {
                '출생년도': '1998',
                '고향': '서울',
                'MBTI': 'ISFJ',
                '학력': '연세대학교 컴퓨터과학과 학사',
                '직업': '인천국제공항공사 전산직',
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFAFAFA),
        foregroundColor: const Color(0xFF616161),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          height: 1.4,
          fontWeight: FontWeight.w600,
          color: Color(0xFF757575),
        ),
      ),
    );
  }
}
