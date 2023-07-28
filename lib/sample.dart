class SampleClass {
  static final SampleClass instance = SampleClass._internal();
  factory SampleClass()=>instance;
  SampleClass._internal();

  int count = 2;

}