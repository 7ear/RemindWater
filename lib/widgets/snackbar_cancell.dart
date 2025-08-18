import '../imports.dart';

class SnackbarCancell extends StatelessWidget {
  const SnackbarCancell({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void showSnackbarCancell(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ListTile(
          title: Text(
            'Задано некорректное число!',
            style: GoogleFonts.manrope(
              textStyle: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          leading: const Icon(
            Icons.cancel,
            size: 25,
            color: Color.fromARGB(255, 255, 0, 0),
          ),
        ),
        margin: const EdgeInsets.only(
          bottom: 100,
          right: 100,
          left: 100,
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
