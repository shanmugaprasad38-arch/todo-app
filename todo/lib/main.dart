
import 'package:flutter/material.dart';

void main() {
  runApp(const DevPathApp());
}

const Color appPurple = Color(0xFF7657E8);

class DevPathApp extends StatefulWidget {
  const DevPathApp({super.key});

  @override
  State<DevPathApp> createState() => _DevPathAppState();
}

class _DevPathAppState extends State<DevPathApp> {
  ThemeMode themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevPath AI',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: appPurple),
        scaffoldBackgroundColor: const Color(0xFFF7F7FC),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: appPurple,
          brightness: Brightness.dark,
        ),
      ),
      home: DevPathHome(
        isDark: themeMode == ThemeMode.dark,
        onThemeChanged: (value) {
          setState(() {
            themeMode = value ? ThemeMode.dark : ThemeMode.light;
          });
        },
      ),
    );
  }
}

class DevPathHome extends StatefulWidget {
  final bool isDark;
  final ValueChanged<bool> onThemeChanged;

  const DevPathHome({
    super.key,
    required this.isDark,
    required this.onThemeChanged,
  });

  @override
  State<DevPathHome> createState() => _DevPathHomeState();
}

class _DevPathHomeState extends State<DevPathHome> {
  int selectedTab = 0;

  final List<Map<String, dynamic>> roadmap = [
    {'title': 'Learn Dart basics', 'level': 'Beginner', 'done': false},
    {'title': 'Master Flutter widgets', 'level': 'Beginner', 'done': false},
    {'title': 'Build a Firebase login', 'level': 'Intermediate', 'done': false},
    {'title': 'Develop a full-stack app', 'level': 'Advanced', 'done': false},
    {'title': 'Prepare for interviews', 'level': 'Advanced', 'done': false},
  ];

  final List<String> practiceProblems = [];
  final List<Map<String, String>> messages = [
    {
      'sender': 'AI Coach',
      'text': 'Welcome! Ask me about programming or career preparation.',
    },
  ];

  final TextEditingController chatController = TextEditingController();

  int get completedTasks =>
      roadmap.where((task) => task['done'] == true).length;

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      buildDashboard(),
      buildRoadmap(),
      buildPractice(),
      buildCoach(),
      buildProfile(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.code, color: appPurple),
            SizedBox(width: 10),
            Text(
              'DevPath AI',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SafeArea(child: pages[selectedTab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedTab,
        onDestinationSelected: (index) {
          setState(() => selectedTab = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.route_outlined),
            selectedIcon: Icon(Icons.route),
            label: 'Roadmap',
          ),
          NavigationDestination(
            icon: Icon(Icons.code_outlined),
            selectedIcon: Icon(Icons.code),
            label: 'Practice',
          ),
          NavigationDestination(
            icon: Icon(Icons.smart_toy_outlined),
            selectedIcon: Icon(Icons.smart_toy),
            label: 'AI Coach',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // HOME DASHBOARD
  Widget buildDashboard() {
    final progress = completedTasks / roadmap.length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Build Your Developer Future 🚀',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Learn skills. Build projects. Track your progress.',
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
        const SizedBox(height: 22),
        Card(
          color: appPurple,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'YOUR CAREER GOAL',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Software Developer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white30,
                  color: Colors.white,
                  minHeight: 8,
                ),
                const SizedBox(height: 8),
                Text(
                  '${(progress * 100).round()}% roadmap completed',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _statCard(
                'Tasks Done',
                '$completedTasks/${roadmap.length}',
                Icons.check_circle_outline,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _statCard(
                'Problems',
                '${practiceProblems.length}',
                Icons.terminal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        const Text(
          "Today's Learning",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.school_outlined),
            ),
            title: const Text('Continue your roadmap'),
            subtitle: const Text('Learn one new skill today'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => setState(() => selectedTab = 1),
          ),
        ),
        Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.code),
            ),
            title: const Text('Practice programming'),
            subtitle: const Text('Record a completed problem'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => setState(() => selectedTab = 2),
          ),
        ),
      ],
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: appPurple, size: 28),
            const SizedBox(height: 12),
            Text(
              value,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  // CAREER ROADMAP
  Widget buildRoadmap() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'My Career Roadmap',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Complete each learning step at your own pace.'),
        const SizedBox(height: 12),
        LinearProgressIndicator(value: completedTasks / roadmap.length),
        const SizedBox(height: 8),
        Text('$completedTasks of ${roadmap.length} tasks completed'),
        const SizedBox(height: 12),
        ...List.generate(roadmap.length, (index) {
          final task = roadmap[index];

          return Card(
            child: CheckboxListTile(
              value: task['done'] as bool,
              activeColor: appPurple,
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(task['title'] as String),
              subtitle: Text(task['level'] as String),
              onChanged: (value) {
                setState(() {
                  task['done'] = value ?? false;
                });
              },
            ),
          );
        }),
      ],
    );
  }

  // CODING PRACTICE TRACKER
  Widget buildPractice() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text(
          'Coding Practice',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Track the programming problems you solve.'),
        const SizedBox(height: 20),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.terminal, size: 55, color: appPurple),
                const SizedBox(height: 10),
                Text(
                  '${practiceProblems.length}',
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Problems completed'),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _addPractice,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Solved Problem'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Practice History',
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
        ),
        if (practiceProblems.isEmpty)
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text('No problems recorded yet. Start practising!'),
          ),
        ...practiceProblems.reversed.map(
          (problem) => Card(
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: appPurple),
              title: Text(problem),
              subtitle: const Text('Completed'),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _addPractice() async {
    final controller = TextEditingController();

    final problem = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add a solved problem'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'Problem name',
            hintText: 'Example: Reverse a string',
          ),
          textCapitalization: TextCapitalization.sentences,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final value = controller.text.trim();
              if (value.isNotEmpty) {
                Navigator.pop(dialogContext, value);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );

    controller.dispose();

    if (problem != null && mounted) {
      setState(() => practiceProblems.add(problem));
    }
  }

  // AI COACH DEMO
  Widget buildCoach() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(Icons.smart_toy, color: appPurple, size: 30),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Interview Coach',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Demo chat — AI API not connected yet'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isUser = message['sender'] == 'You';

              return Align(
                alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 300),
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isUser
                        ? appPurple
                        : Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    message['text']!,
                    style: TextStyle(
                      color: isUser ? Colors.white : null,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: chatController,
                  decoration: const InputDecoration(
                    hintText: 'Ask a programming question...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _sendMessage(),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                onPressed: _sendMessage,
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _sendMessage() {
    final question = chatController.text.trim();
    if (question.isEmpty) return;

    setState(() {
      messages.add({'sender': 'You', 'text': question});
      messages.add({
        'sender': 'AI Coach',
        'text':
            'This is a demo response. Connect a secure AI backend to receive '
                'personalized answers. For now, try learning one topic at a time.',
      });
      chatController.clear();
    });
  }

  // PROFILE AND SETTINGS
  Widget buildProfile() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const CircleAvatar(
          radius: 45,
          backgroundColor: appPurple,
          child: Icon(Icons.person, size: 48, color: Colors.white),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Student Profile',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 6),
        const Center(child: Text('Future Software Developer')),
        const SizedBox(height: 24),
        Card(
          child: ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: const Text('Career Goal'),
            subtitle: const Text('Software Developer'),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Editable career goals will be added later.'),
                ),
              );
            },
          ),
        ),
        Card(
          child: SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: const Text('Dark Mode'),
            value: widget.isDark,
            onChanged: widget.onThemeChanged,
          ),
        ),
        Card(
          child: const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About DevPath AI'),
            subtitle: Text(
              'A learning companion for your software career.',
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Current version: UI prototype. Authentication and cloud sync '
          'are not connected yet.',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
