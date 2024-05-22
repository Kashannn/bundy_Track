import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class StopwatchPage extends StatefulWidget {
  final String labelText;

  const StopwatchPage({Key? key, required this.labelText}) : super(key: key);

  @override
  State<StopwatchPage> createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );
  bool _isRunning = false;

  @override
  void dispose() {
    _stopWatchTimer.dispose();
    super.dispose();
  }

  void _toggleRun() {
    if (_isRunning) {
      _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    } else {
      _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: 0,
                builder: (context, snapshot) {
                  final value = snapshot.data;
                  final displayTime = StopWatchTimer.getDisplayTime(value!);
                  return Text(
                    displayTime,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
              Text(
                '${widget.labelText}:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FloatingActionButton(
                onPressed: _toggleRun,
                backgroundColor: Color(0xFF1A49F2),
                elevation: 1,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1A49F2),
                  ),
                  child: Icon(
                    _isRunning ? Icons.pause : Icons.play_arrow,
                    color: Color(0xFFFFFFFF),
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
