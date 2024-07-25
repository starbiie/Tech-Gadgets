import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: SearchField()),
        const SizedBox(width: 16),
        IconBtnWithCounter(

        ),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged: (value) {},
        decoration: InputDecoration(
          filled: true,
          isDense: true,
          fillColor: kSecondaryColor.withOpacity(0.1),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 19, vertical: 5),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide:
                BorderSide(color: HexColor('#000000').withOpacity(0.30)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide:
                BorderSide(color: HexColor('#000000').withOpacity(0.30)),
          ),
          hintText: "Search for treatments",
          hintStyle: TextStyle(
              fontSize: 13, color: HexColor("#000000").withOpacity(0.25)),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: 75,
      child: Text(
        "Search",
        style: TextStyle(color: Colors.white),
      ),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
      Color.fromRGBO(143, 148, 251, 1),
        Color.fromRGBO(143, 148, 251, .6),
        ]), borderRadius: BorderRadius.circular(8)),
    );
  }
}

const kSecondaryColor = Color(0xFF979797);
