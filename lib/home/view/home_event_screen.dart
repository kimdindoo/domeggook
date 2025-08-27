import 'package:flutter/material.dart';

class EventItem {
  final String imagePath;
  final String title;
  final String subtitle;
  final String period;

  EventItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.period,
  });
}

class HomeEventScreen extends StatelessWidget {
  const HomeEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      EventItem(
        imagePath: 'asset/img/event/event1.png',
        title: '8월 신규가입 시 최대 8천 포인트 지급!',
        subtitle: '첫가입 + 사업자 전환 선착순 이벤트',
        period: '25.08.01 ~ 25.08.31',
      ),
      EventItem(
        imagePath: 'asset/img/event/event2.png',
        title: 'SNS커머스마케터자격증 오픈 EVENT!',
        subtitle: '응시료 할인 + 기출문제 제공 + TOKTAK.AI 이용권 제공!',
        period: '25.05.21 ~ (종료기간 없음)',
      ),
      EventItem(
        imagePath: 'asset/img/event/event3.png',
        title: '자격증취득+창업 준비를 한 번에!',
        subtitle: '자격증시험대비 교육&응시료할인 이벤트!',
        period: '25.03.04 ~ 종료기간 없음)',
      ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return _EventCard(event: event);
      },
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventItem event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            event.imagePath,
            width: double.infinity, // 화면 좌우 가득
            fit: BoxFit.cover, // 비율 유지하면서 채우기
          ),
          const SizedBox(height: 8),
          Text(
            event.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(event.subtitle, style: const TextStyle(color: Colors.grey)),
          Row(
            children: [
              const Text('이벤트 기간', style: TextStyle(color: Colors.red)),
              Text(
                ' l ${event.period}',
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
