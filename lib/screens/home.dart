import '../imports.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    
    loadSavedValue(); 

    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    animation = Tween<double>(begin: 0, end: 0).animate(controller)
      ..addListener(() {
        setState(() {
          totalWaterValue = animation.value;
        });
      }
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      requestNotificationPermission();
      context.read<SharedModel>().addListener(updateFromModel);
      updateFromModel();
    });
  }

  Future<void> loadSavedValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      totalWaterValue = prefs.getDouble('totalWaterValue') ?? 0.0;
      tempValue = prefs.getDouble('tempValue') ?? 0.0;
      flag = prefs.getBool('flag') ?? false;
    });
  }

  void incrementSmoothly() {
    final model = context.read<SharedModel>();
    if (isAnimating) return;

    isAnimating = true;
    tempValue += model.changedWaterValue;
    controller.dispose();
    
    controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => isAnimating = false);
      }
    });
    double endValue = tempValue > model.targetWaterValue ? model.targetWaterValue : tempValue;
    animation = Tween<double>(
      begin: totalWaterValue,
      end: endValue,
    ).animate(controller)
      ..addListener(() {
        if (animation.value >= model.targetWaterValue) {
          controller.stop();
          setState(() => totalWaterValue = model.targetWaterValue);
        } else {
          setState(() => totalWaterValue = animation.value);
        }
      });
    
    saveTotalWaterValue();
    saveTempValue();
    controller.forward();
  }

  Future<void> saveTotalWaterValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('totalWaterValue', totalWaterValue += changedWaterValue);
    await loadSavedValue();
  }

  Future<void> saveTempValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('tempValue', tempValue);
    await loadSavedValue();
  }

  Future<void> resetValues() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('totalWaterValue');
    await prefs.remove('tempValue');
    await prefs.remove('flag');
    await loadSavedValue();
  }

  @override
  void dispose() {
    saveTotalWaterValue();
    saveTempValue();
    controller.dispose();
    context.read<SharedModel>().removeListener(updateFromModel);
    super.dispose();
  }

  void updateFromModel() {
    final model = context.read<SharedModel>();
    setState(() {
      targetWaterValue = model.targetWaterValue;
      changedWaterValue = model.changedWaterValue;
    });
  }

  void controlLimitAddedWater(VoidCallback function){
    final model = context.read<SharedModel>();

    if(model.flag == false){
      if(compareNumbers(100, controllerFieldTargetWater.text) == false){
        targetWaterValue = double.tryParse(controllerFieldTargetWater.text) ?? 2.5;
      }
      if(tempValue < model.targetWaterValue){
        function();
      }
    }
    if(model.flag == true){
      model.updateTargetWaterValue(double.infinity);
      
      function();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SharedModel>(
      builder: (context, model, child) {
        return Scaffold( 
          appBar: AppBar(
            title: Text(widget.title),
            actions: <Widget>[
              IconButton(
                onPressed: () => routeToSettings(context),
                icon: Icon(Icons.settings),
                iconSize: 30,
                color: const Color.fromARGB(172, 0, 0, 0),
              ),
            ],
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [const Color.fromARGB(255, 228, 239, 253), const Color.fromARGB(255, 4, 0, 255)],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 3, left: 3),
                    margin: EdgeInsets.only(top: 60),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${totalWaterValue.toStringAsFixed(2)}л', style: GoogleFonts.oswald(textStyle: theme.textTheme.titleLarge)),
                        if(model.flag == false) Text('/${roundToTenths(model.targetWaterValue)}л', style: GoogleFonts.oswald(textStyle: theme.textTheme.titleMedium)),   
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 3, bottom: 3, left: 6, right: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color.fromARGB(255, 0, 60, 255),
                        width: 1
                      )
                    ),
                    margin: EdgeInsets.only(bottom: 270),
                    child: FutureBuilder(
                      future: getNextNotificationTime(),
                        builder: (context, snapshot) {
                          return snapshot.hasData ? Text('Следущее напоминание в ${timeFormatter.format(snapshot.data!)}', style: GoogleFonts.roboto(textStyle: theme.textTheme.bodySmall)) : CircularProgressIndicator();
                        }
                      ),
                  ),
                  SizedBox(
                    width: 210,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () async {
                        controlLimitAddedWater(incrementSmoothly);
                        if(totalWaterValue == model.targetWaterValue){
                          SnackbarPrize().showSnackbarPrize(context);
                        }
                        if(totalWaterValue > model.targetWaterValue){
                          totalWaterValue = model.targetWaterValue;
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            'assets/images/water.svg',
                            width: 24,
                            height: 24,
                          ),
                          Text('ВЫПИТО', style: GoogleFonts.roboto(textStyle: theme.textTheme.bodyMedium)),
                        ]
                      )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('При нажатии будет добавлено: ${roundToTenths(model.changedWaterValue)}л', style: GoogleFonts.manrope(textStyle: theme.textTheme.titleSmall)),
                        IconButton(
                          onPressed: () => {resetValues(),routeToSettings(context)},
                          icon: SvgPicture.asset(
                            'assets/images/edit.svg',
                            width: 18,
                            height: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ),
        );
      },
    );
  }
}
