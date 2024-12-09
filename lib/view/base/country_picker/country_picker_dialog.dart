import 'package:atobuy_vendor_flutter/view/base/country_picker/countries.dart';
import 'package:atobuy_vendor_flutter/view/base/country_picker/helpers.dart';
import 'package:flutter/material.dart';

class PickerDialogStyle {
  PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.width,
  });
  final Color? backgroundColor;

  final TextStyle? countryCodeStyle;

  final TextStyle? countryNameStyle;

  final Widget? listTileDivider;

  final EdgeInsets? listTilePadding;

  final EdgeInsets? padding;

  final Color? searchFieldCursorColor;

  final InputDecoration? searchFieldInputDecoration;

  final EdgeInsets? searchFieldPadding;

  final double? width;
}

class CountryPickerDialog extends StatefulWidget {
  const CountryPickerDialog({
    final Key? key,
    required this.searchText,
    required this.countryList,
    required this.onCountryChanged,
    required this.selectedCountry,
    required this.filteredCountries,
    this.style,
    required this.isCountryCodeVisible,
  }) : super(key: key);
  final List<Country> countryList;
  final Country selectedCountry;
  final ValueChanged<Country> onCountryChanged;
  final String searchText;
  final List<Country> filteredCountries;
  final PickerDialogStyle? style;
  final bool isCountryCodeVisible;

  @override
  _CountryPickerDialogState createState() => _CountryPickerDialogState();
}

class _CountryPickerDialogState extends State<CountryPickerDialog> {
  late List<Country> _filteredCountries;
  late Country _selectedCountry;

  @override
  void initState() {
    _selectedCountry = widget.selectedCountry;
    _filteredCountries = widget.filteredCountries;

    super.initState();
  }

  @override
  Widget build(final BuildContext context) {
    final double mediaWidth = MediaQuery.of(context).size.width;
    final double width = widget.style?.width ?? mediaWidth;
    const double defaultHorizontalPadding = 40.0;
    const double defaultVerticalPadding = 24.0;
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
          vertical: defaultVerticalPadding,
          horizontal: mediaWidth > (width + defaultHorizontalPadding * 2)
              ? (mediaWidth - width) / 2
              : defaultHorizontalPadding),
      backgroundColor: widget.style?.backgroundColor,
      child: Container(
        padding: widget.style?.padding ?? const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  widget.style?.searchFieldPadding ?? const EdgeInsets.all(0),
              child: TextField(
                cursorColor: widget.style?.searchFieldCursorColor,
                decoration: widget.style?.searchFieldInputDecoration ??
                    InputDecoration(
                      suffixIcon: const Icon(Icons.search),
                      labelText: widget.searchText,
                    ),
                onChanged: (final String value) {
                  _filteredCountries = isNumeric(value)
                      ? widget.countryList
                          .where((final Country country) =>
                              country.dialCode.contains(value))
                          .toList()
                      : widget.countryList
                          .where((final Country country) => country.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                  if (mounted) setState(() {});
                },
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredCountries.length,
                itemBuilder: (final BuildContext ctx, final int index) =>
                    Column(
                  children: <Widget>[
                    ListTile(
                      contentPadding: widget.style?.listTilePadding,
                      title: Text(
                        _filteredCountries[index].name,
                        style: widget.style?.countryNameStyle ??
                            const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      trailing: widget.isCountryCodeVisible
                          ? Text(
                              '+${_filteredCountries[index].dialCode}',
                              style: widget.style?.countryCodeStyle ??
                                  const TextStyle(fontWeight: FontWeight.w700),
                            )
                          : Text(
                              '',
                              style: widget.style?.countryCodeStyle ??
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                      onTap: () {
                        _selectedCountry = _filteredCountries[index];
                        widget.onCountryChanged(_selectedCountry);
                        Navigator.of(context).pop();
                      },
                    ),
                    widget.style?.listTileDivider ??
                        const Divider(thickness: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
