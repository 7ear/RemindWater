import '../imports.dart';

class SnackbarPrize extends StatelessWidget {
  const SnackbarPrize({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void showSnackbarPrize(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ListTile(
          title: Text(
            'Дневная цель достигнута!',
            style: GoogleFonts.manrope(
              textStyle: Theme.of(context).textTheme.labelMedium,
            ),
          ),
          leading: const Icon(
            Icons.emoji_events,
            size: 25,
            color: Color.fromARGB(255, 247, 218, 3),
          ),
        ),
        margin: const EdgeInsets.only(
          bottom: 300,
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
