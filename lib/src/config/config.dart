import 'package:petowner/src/app/setup.locator.dart';
import 'package:petowner/src/enums/sheet_status.dart';
import 'package:pawcastle_designsystem/pawcastle_designsystem.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

void setupConfig() {
  _setupCustomSnackbar();
  _setupPaymentSheet();
}

void _setupCustomSnackbar() {
  final _snackbarService = locator<SnackbarService>();

  _snackbarService.registerCustomSnackbarConfig(
      variant: SnackbarType.success,
      config: SnackbarConfig(
          backgroundColor: kSuccessColor,
          titleColor: kSurfaceColor,
          isDismissible: true,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 110.0),
          borderRadius: 8.0,
          icon: Icon(
            Icons.check_circle,
            color: kSurfaceColor.withOpacity(.1),
          ),
          messageColor: kSurfaceColor));

  _snackbarService.registerCustomSnackbarConfig(
      variant: SnackbarType.failure,
      config: SnackbarConfig(
          backgroundColor: kErrorColor,
          titleColor: kSurfaceColor,
          isDismissible: true,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 110.0),
          borderRadius: 8.0,
          icon: const Icon(
            Icons.info,
            color: kSurfaceColor,
          ),
          messageColor: kSurfaceColor));

  _snackbarService.registerCustomSnackbarConfig(
      variant: SnackbarType.warning,
      config: SnackbarConfig(
          backgroundColor: kWarningColor,
          titleColor: kSurfaceColor,
          isDismissible: true,
          shouldIconPulse: false,
          margin: const EdgeInsets.only(left: 15, right: 15, bottom: 110.0),
          borderRadius: 8.0,
          icon: const Icon(
            Icons.info,
            color: kSurfaceColor,
          ),
          messageColor: kSurfaceColor));
}

void _setupPaymentSheet() {
  final bottomSheetService = locator<BottomSheetService>();

  final builders = {
    SheetStatus.Payment: (context, sheetRequest, completer) =>
        _PaymentSheet(request: sheetRequest, completer: completer)
  };

  bottomSheetService.setCustomSheetBuilders(builders);
}

class _PaymentSheet extends StatefulWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const _PaymentSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  State<_PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends State<_PaymentSheet> {
  PaymentMethod? _paymentMethod = PaymentMethod.cod;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        ListTile(title: UIText.label("Choose Payment Method")),
        RadioListTile<PaymentMethod>(
          value: PaymentMethod.cod,
          groupValue: _paymentMethod,
          onChanged: (val) {
            setState(() {
              _paymentMethod = val;
            });
          },
          title: UIText.paragraph(
            "Cash on Delivery",
            size: TxtSize.Small,
          ),
        ),
        RadioListTile<PaymentMethod>(
          value: PaymentMethod.online,
          groupValue: _paymentMethod,
          onChanged: (val) {
            setState(() {
              _paymentMethod = val;
            });
          },
          isThreeLine: true,
          title: UIText.paragraph(
            "Pay online",
            size: TxtSize.Small,
          ),
          subtitle: UIText.paragraph(
            "(UPI, Debit Card, Credit Card)",
            size: TxtSize.Tiny,
            color: kTextSecondaryLightColor,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
          child: UIButton.primary("Continue",
              onTap: () => widget.completer(SheetResponse<PaymentMethod>(
                  data: _paymentMethod, confirmed: true))),
        ),
      ]),
      color: kSurfaceColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
    );
  }
}
