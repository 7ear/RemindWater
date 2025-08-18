import '../imports.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override void initState() {
    super.initState();
    model = context.read<SharedModel>();
    controllerFieldTargetWater.text = model.targetWaterValue.toString();
    controllerFieldChangedWater.text = model.changedWaterValue.toString();
    initFields();
  }

  late final SharedModel model;

  Future<void> initFields() async {
    await model.loadValues();
    controllerFieldTargetWater.text = model.targetWaterValue.toString();
    controllerFieldChangedWater.text = model.changedWaterValue.toString();
  }

  Future<void> loadSavedValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      targetWaterValue = prefs.getDouble('targetWaterValue') ?? 2.5;
      changedWaterValue = prefs.getDouble('changedWaterValue') ?? 0.3;
    });
  }

  Future<void> saveFlagValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('flag', model.flag);
    await loadSavedValue();
  }

  Future<void> saveTargetWaterValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('targetWaterValue', model.targetWaterValue);
    await loadSavedValue();
  }

  Future<void> saveChangedWaterValue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('changedWaterValue', model.changedWaterValue);
    await loadSavedValue();
  }

  void changeTargetWaterValue(){
    context.read<SharedModel>().updateTargetWaterValue(
      double.tryParse(controllerFieldTargetWater.text) ?? 2.5
    );

    setState(() {
      targetWaterValue = double.tryParse(controllerFieldTargetWater.text) ?? 2.5;
    });
  }

  void changeChangedWaterValue(){
    context.read<SharedModel>().updateChangedWaterValue(
      double.tryParse(controllerFieldChangedWater.text) ?? 0.3
    );

    setState(() {
      changedWaterValue = double.tryParse(controllerFieldChangedWater.text) ?? 0.3;
    });
  }

  void changeFlagValue(){
    context.read<SharedModel>().updateFlagValue(true);

    setState(() {
      flag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 26, 255),
      appBar: AppBar(
        title: 
          Text('Settings', style: GoogleFonts.archivo(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.w800,
            fontSize: 26
          )
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(40, 255, 255, 255),
            ),
            width: double.infinity,
            height: 100,
            margin: EdgeInsets.only(top: 50, right: 20, left: 20),

            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.water_drop_outlined,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    size: 25
                  ),
                  title: Text('Цель на день', style: GoogleFonts.manrope(textStyle: theme.textTheme.bodyLarge)),
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${model.targetWaterValue}л ', style: GoogleFonts.manrope(textStyle: theme.textTheme.bodyLarge)),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: const Color.fromARGB(200, 255, 255, 255),
                        size: 17,
                      )
                    ],  
                  ),
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => 
                    AlertDialog(
                      title: Text('Задайте новую цель на день', style: GoogleFonts.manrope(textStyle: theme.textTheme.bodyMedium)),
                      content: SizedBox(
                        child: TextField(
                          controller: controllerFieldTargetWater,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                          ],
                          decoration: InputDecoration(
                            suffixText: 'л',
                            suffixStyle: GoogleFonts.manrope(textStyle: theme.textTheme.titleMedium),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Отменить'),
                          child: Text('Отменить', style: GoogleFonts.manrope(color: const Color.fromARGB(255, 141, 141, 141), fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                        TextButton(
                          onPressed: () {
                            if(compareNumbers(100, controllerFieldTargetWater.text) == true){
                              return SnackbarCancell().showSnackbarCancell(context);
                            } else {
                              changeTargetWaterValue();
                              saveTargetWaterValue();
                              setState(() {}); 
                              Navigator.pop(context, 'Сохранить');
                              SnackbarSuccess().showSnackbarSuccess(context);
                            }
                          },
                          child: Text('Сохранить', style: GoogleFonts.manrope(textStyle: theme.textTheme.labelSmall)),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  leading: 
                    SvgPicture.asset(
                      'assets/images/glass_of_water.svg',
                      width: 25,
                      height: 25,
                    ),
                  title: Text('Добавленный объем', style: GoogleFonts.manrope(textStyle: theme.textTheme.bodyLarge)),
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${changedWaterValue}л ', style: GoogleFonts.manrope(textStyle: theme.textTheme.bodyLarge)),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: const Color.fromARGB(200, 255, 255, 255),
                        size: 17,
                      )
                    ],  
                  ),
                  onTap: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => 
                    AlertDialog(
                      title: Text('Задайте новый объем', style: GoogleFonts.manrope(textStyle: theme.textTheme.bodyMedium)),
                      content: SizedBox(
                        child: TextField(
                          controller: controllerFieldChangedWater,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                          ],
                          decoration: InputDecoration(
                            suffixText: 'л',
                            suffixStyle: GoogleFonts.manrope(textStyle: theme.textTheme.titleMedium),
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Отменить'),
                          child: Text('Отменить', style: GoogleFonts.manrope(color: const Color.fromARGB(255, 141, 141, 141), fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                        TextButton(
                          onPressed: () {
                            if(compareNumbers(5, controllerFieldChangedWater.text) == true){
                              return SnackbarCancell().showSnackbarCancell(context);
                            } else {
                              changeChangedWaterValue();
                              context.read<SharedModel>().updateChangedWaterValue(changedWaterValue);
                              saveChangedWaterValue();
                              Navigator.pop(context, 'Сохранить');
                              SnackbarSuccess().showSnackbarSuccess(context);
                            }
                          },
                          child: Text('Сохранить', style: GoogleFonts.manrope(textStyle: theme.textTheme.labelSmall)),
                        ),
                      ],
                    ),
                  )
                ),
              ]
            ),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(40, 255, 255, 255),
            ),
            width: double.infinity,
            height: 50,
            margin: EdgeInsets.only(top: 20, right: 20, left: 20),

            child: ListView(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.cancel_outlined,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    size: 25
                  ),
                  title: Text('Отключить лимит', style: GoogleFonts.manrope(textStyle: theme.textTheme.bodyLarge)),
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  trailing: GestureDetector(
                    onTap: () => setState(() {
                      // flag = !flag;
                      changeFlagValue();
                      saveFlagValue();
                    }),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 51,
                      height: 31,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: flag
                            ? const Color(0xFF34C759)
                            : Colors.grey[400]!,
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            left: flag ? 20 : 0,
                            child: Container(
                              width: 25,
                              height: 25,
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: flag
                                    ? Colors.white
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(13),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(10, 0, 0, 0),
                                    blurRadius: 2,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    )
                  ),
                ),
              ]
            ),
          ),
          Container(

          ),
        ],
      )
    );
  }
}