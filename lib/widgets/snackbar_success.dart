import '../imports.dart';

class SnackbarSuccess extends StatelessWidget {
  const SnackbarSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void showSnackbarSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ListTile(
          title: Text(
            'Успешно сохранено!',
            style: GoogleFonts.manrope(
              textStyle: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          leading: const Icon(
            Icons.check_circle_rounded,
            size: 25,
            color: Color.fromARGB(255, 47, 229, 19),
          ),
        ),
        margin: const EdgeInsets.only(
          bottom: 100,
          right: 40,
          left: 40,
        ),
        duration: const Duration(seconds: 2),
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: const Color.fromARGB(255, 39, 39, 39),
        elevation: 0,
      ),
    );
  }
}
