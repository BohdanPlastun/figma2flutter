import 'dart:io';

import 'package:figma2flutter/models/token_theme.dart';
import 'package:figma2flutter/transformers/color_transformer.dart';
import 'package:figma2flutter/transformers/typography_transformer.dart';

const _genWarning = '''
/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
/// Figma2Flutter
/// *****************************************************''';

class ThemeColorExtensionGenerator {
  ThemeColorExtensionGenerator(this.themes);

  final List<TokenTheme> themes;

  String generate() {
    var output = '';

    output += _genWarning;

    output += "\n\n import 'package:flutter/material.dart'; \n\n";

    final theme = themes.first;
    output += 'class AppColorsExtension extends ThemeExtension<AppColorsExtension> {\n';
    output += '  const AppColorsExtension({\n';

    // Generate properties
    for (var token in theme.resolvedTokens) {
      if (token.type == 'color') {
        output += '    required this.${token.variableName},\n';
      }
    }

    output += '  });\n\n';

    // Generate properties again for final declaration
    for (var token in theme.resolvedTokens) {
      if (token.type == 'color') {
        output += '  final Color ${token.variableName};\n';
      }
    }

    // Generate copyWith method
    output += '\n  @override\n';
    output += '  ThemeExtension<AppColorsExtension> copyWith({\n';
    for (var token in theme.resolvedTokens) {
      if (token.type == 'color') {
        output += '    Color? ${token.variableName},\n';
      }
    }
    output += '  }) {\n';
    output += '    return AppColorsExtension(\n';
    for (var token in theme.resolvedTokens) {
      if (token.type == 'color') {
        output +=
            '      ${token.variableName}: ${token.variableName} ?? this.${token.variableName},\n';
      }
    }
    output += '    );\n';
    output += '  }\n\n';

    // Generate lerp method
    output += '  @override\n';
    output += '  ThemeExtension<AppColorsExtension> lerp(\n';
    output += '    covariant ThemeExtension<AppColorsExtension>? other,\n';
    output += '    double t,\n';
    output += '  ) {\n';
    output += '    if (other is! AppColorsExtension) {\n';
    output += '      return this;\n';
    output += '    }\n\n';
    output += '    return AppColorsExtension(\n';
    for (var token in theme.resolvedTokens) {
      if (token.type == 'color') {
        output +=
            '      ${token.variableName}: Color.lerp(${token.variableName}, other.${token.variableName}, t)!,\n';
      }
    }
    output += '    );\n';
    output += '  }\n';

    output += '}\n\n';

    final colorTransformer = ColorTransformer();

    // Generate AppColorsExtension instances for light and dark themes
    output += 'const lightAppColors = AppColorsExtension(\n';
    for (var token in themes.first.resolvedTokens) {
      if (token.type == 'color') {
        var colorDeclaration = colorTransformer.transform(token);
        output += '  ${token.variableName}: $colorDeclaration, \n';
      }
    }
    output += ');\n\n';

    output += 'const darkAppColors = AppColorsExtension(\n';
    for (var token in themes[1].resolvedTokens) {
      if (token.type == 'color') {
        final colorDeclaration = colorTransformer.transform(token);
        output += '  ${token.variableName}: $colorDeclaration, \n';
      }
    }
    output += ');\n';

    return output;
  }

  void save(String outputDirectory) {
    final dir = Directory(outputDirectory)..createSync(recursive: true);

    _save(generate(), to: '${dir.path}/theme_extension.g.dart');
  }

  void _save(String content, {required String to}) {
    final file = File(to);
    if (file.existsSync()) {
      file.deleteSync();
    }
    file.writeAsStringSync(content);
  }
}

class AppTextThemeExtension {
  AppTextThemeExtension(this.themes);

  final List<TokenTheme> themes;

  String generate() {
    final theme = themes.first;

    var output = '';

    output += _genWarning;

    output += "\n\n import 'package:flutter/material.dart'; \n\n";

    output += 'class AppTextThemeExtension extends ThemeExtension<AppTextThemeExtension> {\n';
    output += '  const AppTextThemeExtension({\n';

    // Generate required properties
    for (var token in theme.resolvedTokens) {
      if (token.type == 'typography') {
        output += '    required this.${token.variableName},\n';
      }
    }

    output += '  });\n\n';

    // Generate final properties
    for (var token in theme.resolvedTokens) {
      if (token.type == 'typography') {
        output += '  final TextStyle? ${token.variableName};\n';
      }
    }

    // Generate copyWith method
    output += '\n  @override\n';
    output += '  ThemeExtension<AppTextThemeExtension> copyWith({\n';
    for (var token in theme.resolvedTokens) {
      if (token.type == 'typography') {
        output += '    TextStyle? ${token.variableName},\n';
      }
    }
    output += '  }) {\n';
    output += '    return AppTextThemeExtension(\n';
    for (var token in theme.resolvedTokens) {
      if (token.type == 'typography') {
        output +=
            '      ${token.variableName}: ${token.variableName} ?? this.${token.variableName},\n';
      }
    }
    output += '    );\n';
    output += '  }\n\n';

    // Generate lerp method
    output += '  @override\n';
    output += '  ThemeExtension<AppTextThemeExtension> lerp(\n';
    output += '    covariant ThemeExtension<AppTextThemeExtension>? other,\n';
    output += '    double t,\n';
    output += '  ) {\n';
    output += '    if (other is! AppTextThemeExtension) {\n';
    output += '      return this;\n';
    output += '    }\n\n';
    output += '    return AppTextThemeExtension(\n';
    for (var token in theme.resolvedTokens) {
      if (token.type == 'typography') {
        output +=
            '      ${token.variableName}: TextStyle.lerp(${token.variableName}, other.${token.variableName}, t),\n';
      }
    }
    output += '    );\n';
    output += '  }\n';

    output += '}\n';

    return output;
  }

  void save(String outputDirectory) {
    final dir = Directory(outputDirectory)..createSync(recursive: true);

    _save(generate(), to: '${dir.path}/text_theme_extension.g.dart');
  }

  void _save(String content, {required String to}) {
    final file = File(to);
    if (file.existsSync()) {
      file.deleteSync();
    }
    file.writeAsStringSync(content);
  }
}

class AppTypographyGenerator {
  AppTypographyGenerator(this.themes);

  final List<TokenTheme> themes;

  String generate() {
    var output = '';

    output += _genWarning;

    output += "\n\nimport 'package:flutter/material.dart'; \n";
    output += "import 'package:workload_flutter/assets/tokens/text_theme_extension.g.dart';\n\n";

    output += 'abstract class AppTypography {\n';

    final typographyTransformer = TypographyTransformer();
    // Generate static final properties
    for (var token in themes.first.resolvedTokens) {
      if (token.type == 'typography') {
        output +=
            '  static const ${token.variableName} = ${typographyTransformer.transform(token)};\n';
      }
    }

    output += '\n  static AppTextThemeExtension applyTextColor(Color color) {\n';
    output += '    return AppTextThemeExtension(\n';

    // Generate copyWith method calls
    for (var token in themes.first.resolvedTokens) {
      if (token.type == 'typography') {
        output += '      ${token.variableName}: ${token.variableName}.copyWith(color: color),\n';
      }
    }

    output += '    );\n';
    output += '  }\n';
    output += '}\n';

    return output;
  }

  void save(String outputDirectory) {
    final dir = Directory(outputDirectory)..createSync(recursive: true);

    _save(generate(), to: '${dir.path}/app_typography.g.dart');
  }

  void _save(String content, {required String to}) {
    final file = File(to);
    if (file.existsSync()) {
      file.deleteSync();
    }
    file.writeAsStringSync(content);
  }
}
