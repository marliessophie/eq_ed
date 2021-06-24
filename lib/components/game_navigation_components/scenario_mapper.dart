enum ScenarioNumber {
  one,
  two,
  three,
  none,
}

class ScenarioMapper {
  static Map<ScenarioNumber, String> scenarios = {
    ScenarioNumber.one: 'Team Meeting',
    ScenarioNumber.two: 'Uni Presentation',
    ScenarioNumber.three: 'Classroom',
  };
}
