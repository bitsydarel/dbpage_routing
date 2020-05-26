import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';
import "package:dbpage_routing/dbpage_routing.dart";

class TestAnnotationGenerator extends GeneratorForAnnotation<TestAnnotation> {
  const TestAnnotationGenerator();

  @override
  generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final testClass = element as ClassElement;

    final formatter = DartEmitter();
    final parameters = <Parameter>[];
    final fields = <Field>[];

    for (final testField in testClass.fields) {
      final annotation = const TypeChecker.fromRuntime(TestAnnotation)
          .firstAnnotationOfExact(testField, throwOnUnresolved: false);

      final valueField = annotation.getField("value");

      final field = FieldBuilder()
        ..name = testField.name
        ..type = Reference(valueField.type.getDisplayString())
        ..modifier = FieldModifier.final$;

      fields.add(field.build());

      final parameter = ParameterBuilder()
        ..name = testField.name
        ..named = true
        ..toThis = true
        ..defaultTo = Code("${_getFieldValue(valueField, formatter)}");

      parameters.add(parameter.build());
    }

    final constructor = ConstructorBuilder()
      ..constant = true
      ..optionalParameters.addAll(parameters);

    final classOutput = ClassBuilder()
      ..name = "\$${testClass.name}"
      ..fields.addAll(fields)
      ..constructors.add(constructor.build());

    final output = classOutput.build().accept(formatter).toString();

    log.info("\n\n$output");

    return output;
  }

  dynamic _getFieldValue(DartObject field, DartEmitter formatter) {
    switch (field.type.getDisplayString()) {
      case "String":
        return "\"${field.toStringValue()}\"";
      case "int":
        return field.toIntValue();
      case "double":
        return field.toDoubleValue();
      case "bool":
        return field.toBoolValue();
      default:
        return _toClass(field, formatter);
    }
  }

  String _toClass(DartObject field, DartEmitter formatter) {
    final fieldClass = field.type.element as ClassElement;

    final fieldConstructor = fieldClass.constructors
        .firstWhere((constructor) => constructor.isConst);

    final requiredParameters = _fieldToRequiredParameter(
      field,
      fieldConstructor,
      formatter,
    );

    final output = StringBuffer()
      ..write("const ")
      ..write(fieldClass.name)
      ..write("(")
      ..write(_listToString(requiredParameters));

    final positionalParameters = _fieldToPositionParameter(
      field,
      fieldConstructor,
      formatter,
    );

    if (positionalParameters.isNotEmpty) {
      output..write(", ")..write(_listToString(positionalParameters));
    }

    final namedParameters = _fieldToOptionalNamedParameter(
      field,
      fieldConstructor,
      formatter,
    );

    if (namedParameters.isNotEmpty) {
      output..write(", ")..write(_listToString(namedParameters))..write(",");
    }

    output.write(")");

    return output.toString();
  }

  List<String> _fieldToRequiredParameter(
    DartObject fieldValue,
    ConstructorElement constructor,
    DartEmitter formatter,
  ) {
    final parameters = <String>[];

    for (final parameter in constructor.parameters) {
      if (parameter.isRequiredPositional) {
        final field = fieldValue.getField(parameter.name);

        parameters.add(_getFieldValue(field, formatter));
      }
    }

    return parameters;
  }

  List<String> _fieldToPositionParameter(
    DartObject fieldValue,
    ConstructorElement constructor,
    DartEmitter formatter,
  ) {
    final parameters = <String>[];

    for (final parameter in constructor.parameters) {
      if (parameter.isOptionalPositional) {
        final field = fieldValue.getField(parameter.name);

        parameters.add(_getFieldValue(field, formatter).toString());
      }
    }

    return parameters;
  }

  List<String> _fieldToOptionalNamedParameter(
    DartObject fieldValue,
    ConstructorElement constructor,
    DartEmitter formatter,
  ) {
    final parameters = <String>[];

    for (final parameter in constructor.parameters) {
      if (parameter.isRequiredNamed || parameter.isOptionalNamed) {
        final field = fieldValue.getField(parameter.name);

        parameters.add(
          "${parameter.name}: ${_getFieldValue(field, formatter)}",
        );
      }
    }

    return parameters;
  }

  String _listToString(List elements) {
    return elements.isEmpty ? "" : elements.join(", ");
  }
}
