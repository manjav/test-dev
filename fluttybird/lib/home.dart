class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

enum GameState { start, jumping, falling, end }

class _HomePageState extends State<HomePage> {
  GameState state = GameState.end;
  static const FPS = 40;
  int delta = (1000 / FPS).round();
  int time = 0;
  int duration;
  int startTime;
  Timer timer;

  double from;
  double to;
  void start() {
    state = GameState.start;
    if (timer == null)
      timer = Timer.periodic(Duration(milliseconds: delta), update);
  }
  void jump() {
    if (state == GameState.end) start();
    from = birdY;
    to = birdY - 150;
    duration = 500;
    startTime = time;
    state = GameState.jumping;
  }

  void fall() {
    from = birdY;
    to = 700;
    startTime = time;
    duration = ((to - from) / 0.7).round();
    state = GameState.falling;
  }

  void end() {
    state = GameState.end;
  }

  void update(Timer timer) {
    time += delta;
    if (state == GameState.jumping) {
      easeOut(time - startTime, fall);
    } else if (state == GameState.falling) {
      easeIn(time - startTime, end);
    }
  }

  void easeIn(int t, Function() onEnd) {
  }

  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('y $state')),
        body: GestureDetector(
          onTap: jump,
          child: Stack(
            children: [
              Positioned(
                  child: Container(
                color: Colors.green,
              )),
              Positioned(
                child: Container(
                  // transform: new Matrix4.rotationZ(birdAngle),
                  child: MyBird(),
                ),
                left: 75,
                top: birdY,
              )
            ],
          ),
        ));
  }
}

class MyBird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 60, height: 60, child: Image.asset("assets/images/bird.png"));
  }
}
