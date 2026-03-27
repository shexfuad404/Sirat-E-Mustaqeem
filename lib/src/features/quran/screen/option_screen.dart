import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/util/constants.dart';
import '../../utils/custom_switch.dart';
import '../../utils/bottom_sheet_select.dart';
import '../bloc/quran_theme/quran_theme_bloc.dart';

const List<String> _quranTypes = ['Normal', 'QCF'];
const List<String> _translationModes = [
  'Urdu',
  'English (Saheeh)',
  'English (Clear Quran)',
  'Turkish (Saheeh)',
  'Malayalam (Abdul Hameed)',
  'Persian (Hussein Dari)',
  'French (Hamidullah)',
  'Italian (Piccardo)',
  'Dutch (Siregar)',
  'Portuguese',
  'Russian (Kuliev)',
  'Bengali',
  'Indonesian',
  'Chinese',
  'Spanish',
  'Swedish',
];
const List<String> _normalQuranFonts = ['Uthman', 'arsura'];
const List<String> _qcfScrollDirections = ['Vertical', 'Horizontal'];
const List<String> _translationGoogleFonts = [
  'Poppins',
  'Roboto',
  'Noto Sans',
  'Lato',
  'Montserrat',
];
const List<String> _audioEditions = [
  'ar.alafasy',
  'ar.abdurrahmaansudais',
  'ar.husary',
  'ar.minshawi',
];
const List<int> _audioBitrates = [192, 128, 64, 48, 40, 32];

class OptionScreen extends StatelessWidget {
  const OptionScreen();

  List<Widget> _buildSettingsItems(QuranThemeState state) {
    final items = <Widget>[
      const QuranTypeOption(),
      if (state.quranType == 'QCF') const QcfScrollDirectionOption(),
      const ShowTranslationOption(),
      const TranslationMode(),
      const AudioEditionOption(),
      const AudioBitrateOption(),
      if (state.quranType != 'QCF') const QuranFontSize(),
      if (state.quranType != 'QCF') const QuranFontFamily(),
      const TranslationFontSize(),
      const TranslationFontFamily(),
    ];

    final separated = <Widget>[];
    for (var i = 0; i < items.length; i++) {
      separated.add(items[i]);
      if (i != items.length - 1) {
        separated.add(const Divider());
      }
    }
    return separated;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quran Styling Option',
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: kPagePadding,
            child: BlocBuilder<QuranThemeBloc, QuranThemeState>(
              builder: (context, state) {
                return Column(
                  children: [
                    SizedBox(
                      height: 16.h,
                    ),
                    ..._buildSettingsItems(state),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class AudioEditionOption extends StatelessWidget {
  const AudioEditionOption();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranThemeBloc, QuranThemeState>(
      builder: (context, state) {
        final value =
            _audioEditions.contains(state.audioEdition) ? state.audioEdition : _audioEditions.first;
        return BottomSheetSelect<String>(
          label: 'Audio reciter',
          value: value,
          options: _audioEditions,
          onChanged: (edition) {
            BlocProvider.of<QuranThemeBloc>(context).add(SetAudioEdition(edition));
          },
        );
      },
    );
  }
}

class AudioBitrateOption extends StatelessWidget {
  const AudioBitrateOption();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranThemeBloc, QuranThemeState>(
      builder: (context, state) {
        final value =
            _audioBitrates.contains(state.audioBitrate) ? state.audioBitrate : _audioBitrates[1];
        return BottomSheetSelect<int>(
          label: 'Audio quality',
          value: value,
          options: _audioBitrates,
          optionLabelBuilder: (v) => '${v}kbps',
          onChanged: (bitrate) {
            BlocProvider.of<QuranThemeBloc>(context)
                .add(SetAudioBitrate(bitrate));
          },
        );
      },
    );
  }
}

class ShowTranslationOption extends StatelessWidget {
  const ShowTranslationOption();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Show translation',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          BlocBuilder<QuranThemeBloc, QuranThemeState>(
            builder: (context, state) {
              return CustomSwitch(
                  value: state.showTranslation,
                  onChanged: (val) {
                    BlocProvider.of<QuranThemeBloc>(context).add(
                      ShowTranslation(val),
                    );
                  });
            },
          ),
        ],
      ),
    );
  }
}

class TranslationMode extends StatelessWidget {
  const TranslationMode();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranThemeBloc, QuranThemeState>(
      builder: (context, state) {
        return BottomSheetSelect<String>(
          label: 'Translation mode',
          value: state.translationMode,
          options: _translationModes,
          onChanged: (value) {
            BlocProvider.of<QuranThemeBloc>(context)
                .add(SwitchTranslationMode(value));
          },
        );
      },
    );
  }
}

class QuranFontSize extends StatelessWidget {
  const QuranFontSize();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranThemeBloc, QuranThemeState>(
      builder: (context, state) {
        if (state.quranType == 'QCF') {
          return const SizedBox.shrink();
        }

        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  'Quran font size',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (BlocProvider.of<QuranThemeBloc>(context)
                          .state
                          .quranFontSize >
                      1) {
                    BlocProvider.of<QuranThemeBloc>(context)
                        .add(ReduceQuranFontSize());
                  }
                },
                child: SvgPicture.asset(
                  'assets/images/quran_icon/svg/minus.svg',
                  color: Theme.of(context).primaryColor,
                  width: 24.w,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                '${state.quranFontSize}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(
                width: 8.w,
              ),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<QuranThemeBloc>(context)
                      .add(AddQuranFontSize());
                },
                child: SvgPicture.asset(
                  'assets/images/quran_icon/svg/add.svg',
                  color: Theme.of(context).primaryColor,
                  width: 24.w,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class QuranFontFamily extends StatelessWidget {
  const QuranFontFamily();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranThemeBloc, QuranThemeState>(
      builder: (context, state) {
        if (state.quranType == 'QCF') {
          return const SizedBox.shrink();
        }

        return BottomSheetSelect<String>(
          label: 'Quran font family',
          value: state.quranFontFamily,
          options: _normalQuranFonts,
          onChanged: (value) {
            BlocProvider.of<QuranThemeBloc>(context)
                .add(SetQuranFontFamily(value));
          },
        );
      },
    );
  }
}

class TranslationFontSize extends StatelessWidget {
  const TranslationFontSize();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Translation font size',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (BlocProvider.of<QuranThemeBloc>(context)
                      .state
                      .translationFontSize >
                  1)
                BlocProvider.of<QuranThemeBloc>(context)
                    .add(ReduceTranslationFontSize());
            },
            child: SvgPicture.asset(
              'assets/images/quran_icon/svg/minus.svg',
              color: Theme.of(context).primaryColor,
              width: 24.w,
            ),
          ),
          SizedBox(
            width: 8.w,
          ),
          BlocBuilder<QuranThemeBloc, QuranThemeState>(
            builder: (context, state) {
              return Text(
                '${state.translationFontSize}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              );
            },
          ),
          SizedBox(
            width: 8.w,
          ),
          GestureDetector(
            onTap: () {
              BlocProvider.of<QuranThemeBloc>(context)
                  .add(AddTranslationFontSize());
            },
            child: SvgPicture.asset(
              'assets/images/quran_icon/svg/add.svg',
              color: Theme.of(context).primaryColor,
              width: 24.w,
            ),
          ),
        ],
      ),
    );
  }
}

class TranslationFontFamily extends StatelessWidget {
  const TranslationFontFamily();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranThemeBloc, QuranThemeState>(
      builder: (context, state) {
        final bool isUrdu = state.translationMode == 'Urdu';
        final options = isUrdu ? const ['Jameel'] : _translationGoogleFonts;

        final selectedValue = options.contains(state.translationFontFamily)
            ? state.translationFontFamily
            : options.first;

        return BottomSheetSelect<String>(
          label: 'Translation font family',
          value: selectedValue,
          options: options,
          onChanged: (value) {
            BlocProvider.of<QuranThemeBloc>(context)
                .add(SetTranslationFontFamily(value));
          },
        );
      },
    );
  }
}

class QuranTypeOption extends StatelessWidget {
  const QuranTypeOption();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranThemeBloc, QuranThemeState>(
      builder: (context, state) {
        return BottomSheetSelect<String>(
          label: 'Quran type',
          value: state.quranType,
          options: _quranTypes,
          onChanged: (value) {
            BlocProvider.of<QuranThemeBloc>(context).add(SetQuranType(value));
          },
        );
      },
    );
  }
}

class QcfScrollDirectionOption extends StatelessWidget {
  const QcfScrollDirectionOption();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuranThemeBloc, QuranThemeState>(
      builder: (context, state) {
        if (state.quranType != 'QCF') {
          return const SizedBox.shrink();
        }

        return BottomSheetSelect<String>(
          label: 'QCF scroll direction',
          value: state.qcfScrollDirection,
          options: _qcfScrollDirections,
          onChanged: (value) {
            BlocProvider.of<QuranThemeBloc>(context)
                .add(SetQcfScrollDirection(value));
          },
        );
      },
    );
  }
}
