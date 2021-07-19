import 'package:equatable/equatable.dart';

class AppPageSection extends Equatable {
  const AppPageSection({
    required this.id,
    required this.type,
    required this.value,
  });

  final String id;
  final String type;
  final String value;

  @override
  List<Object> get props => [id, type, value];

  @override
  bool get stringify => true;

  factory AppPageSection.fromMap(Map<dynamic, dynamic>? value, String id) {
    if (value == null) {
      throw StateError('missing data for appPageSectionId: $id');
    }
    return AppPageSection(
      id: id,
      type: value['type'],
      value: value['value'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'value': value,
    };
  }
}

class AppPage extends Equatable {
  const AppPage({
    required this.id,
    required this.sections,
  });

  final String id;
  final List<AppPageSection> sections;

  @override
  List<Object> get props => [id, sections];

  @override
  bool get stringify => true;

  factory AppPage.fromMap(Map<dynamic, dynamic>? value, String id) {
    if (value == null) {
      throw StateError('missing data for appPageId: $id');
    }
    final sections = <AppPageSection>[];
    for (final section in value['sections']) {
      sections.add(AppPageSection.fromMap(section, section.id));
    }
    return AppPage(id: id, sections: sections);
  }

  Map<String, dynamic> toMap() {
    final sections = <Map<String, dynamic>>[];
    for (final section in this.sections) {
      sections.add(section.toMap());
    }
    return <String, dynamic>{
      'sections': sections,
    };
  }
}
