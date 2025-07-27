import 'package:ai_whisper_app/core/services/api_service.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart'; 

class PredictPage extends StatefulWidget {
  const PredictPage({super.key});

  @override
  State<PredictPage> createState() => _PredictPageState();
}

class _PredictPageState extends State<PredictPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for numeric inputs
  final sessionLengthController = TextEditingController();
  final totalPromptsController = TextEditingController();
  final assistanceLevelController = TextEditingController();

  // Dropdown selections
  String? studentLevel;
  String? discipline;
  String? taskType;
  String? finalOutcome;
  bool usedAgain = false;

  String result = "";

  // Dropdown options
  final List<String> studentLevels = ['High School', 'Undergraduate'];
  final List<String> disciplines = [
    'Business', 'Computer Science', 'Engineering', 'History', 'Math', 'Psychology'
  ];
  final List<String> taskTypes = [
    'Coding', 'Homework Help', 'Research', 'Studying', 'Writing'
  ];
  final List<String> finalOutcomes = ['Confused', 'Gave Up', 'Idea Drafted'];

  void _predict() async {
    print('Predict button pressed');
    if (!_formKey.currentState!.validate()) return;

    // Convert to one-hot format
    Map<String, dynamic> input = {
      "SessionLengthMin": double.parse(sessionLengthController.text),
      "TotalPrompts": double.parse(totalPromptsController.text),
      "AI_AssistanceLevel": double.parse(assistanceLevelController.text),
      "UsedAgain": usedAgain ? 1 : 0,
      // One-hot encoded fields
      "StudentLevel_High_School": studentLevel == 'High School' ? 1 : 0,
      "StudentLevel_Undergraduate": studentLevel == 'Undergraduate' ? 1 : 0,
      "Discipline_Business": discipline == 'Business' ? 1 : 0,
      "Discipline_Computer_Science": discipline == 'Computer Science' ? 1 : 0,
      "Discipline_Engineering": discipline == 'Engineering' ? 1 : 0,
      "Discipline_History": discipline == 'History' ? 1 : 0,
      "Discipline_Math": discipline == 'Math' ? 1 : 0,
      "Discipline_Psychology": discipline == 'Psychology' ? 1 : 0,
      "TaskType_Coding": taskType == 'Coding' ? 1 : 0,
      "TaskType_Homework_Help": taskType == 'Homework Help' ? 1 : 0,
      "TaskType_Research": taskType == 'Research' ? 1 : 0,
      "TaskType_Studying": taskType == 'Studying' ? 1 : 0,
      "TaskType_Writing": taskType == 'Writing' ? 1 : 0,
      "FinalOutcome_Confused": finalOutcome == 'Confused' ? 1 : 0,
      "FinalOutcome_Gave_Up": finalOutcome == 'Gave Up' ? 1 : 0,
      "FinalOutcome_Idea_Drafted": finalOutcome == 'Idea Drafted' ? 1 : 0,
    };

    try {
      final prediction = await ApiService.predict(input);
      setState(() => result = "Predicted Satisfaction: ${prediction.toStringAsFixed(2)}");
    } catch (e) {
      setState(() => result = "Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text.rich(
        TextSpan(
          text: 'AIWhisper  ',
          style: TextStyle(
            fontFamily: 'KaushanScript',
            fontSize: 35,
            color: Color(0xFF555D50)
          ),

          children: <TextSpan> [
            TextSpan(
              text: ' AI Satisfaction Predictor',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 28,
              )
            ),
          ],
        ),       
      ),
      ),
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(53),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: sessionLengthController,
                decoration: const InputDecoration(labelText: "Session Length (min 0 - 500)",
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF555D50),
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                )),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? "Required" : null,
              ),

              TextFormField(
                controller: totalPromptsController,
                decoration: const InputDecoration(labelText: "Total Prompts",
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF555D50),
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                )),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? "Required" : null,
              ),

              TextFormField(
                controller: assistanceLevelController,
                decoration: const InputDecoration(labelText: "AI Assistance Level(0 - 5)",
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF555D50),
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                )),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? "Required" : null,
              ),

              const SizedBox(height: 10),

              // Student Level Dropdown
              DropdownButtonFormField<String>(
                value: studentLevel,
                items: studentLevels
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => studentLevel = val),
                decoration: const InputDecoration(labelText: "Student Level",
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF555D50),
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                )
                ),
                validator: (value) => value == null ? "Required" : null,
              ),

              DropdownButtonFormField<String>(
                value: discipline,
                items: disciplines
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => discipline = val),
                decoration: const InputDecoration(labelText: "Discipline",
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF555D50),
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                )   
                ),
                validator: (value) => value == null ? "Required" : null,
              ),

              DropdownButtonFormField<String>(
                value: taskType,
                items: taskTypes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => taskType = val),
                decoration: const InputDecoration(labelText: "Task Type",
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF555D50),
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                )
                ),
                validator: (value) => value == null ? "Required" : null,
              ),

              DropdownButtonFormField<String>(
                value: finalOutcome,
                items: finalOutcomes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) => setState(() => finalOutcome = val),
                decoration: const InputDecoration(labelText: "Final Outcome",
                labelStyle: TextStyle(
                  fontFamily: 'Inter',
                  color: Color(0xFF555D50),
                  fontSize: 16,
                  fontWeight: FontWeight.normal
                )),
                validator: (value) => value == null ? "Required" : null,
              ),

              SwitchListTile(
                title: const Text(
                  "Used Again?",
                   style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Inter',
                  color: Color(0XFF555D50)
                   ),
                  ),
                value: usedAgain,
                onChanged: (val) => setState(() => usedAgain = val),
                activeColor: Color(0xFFC08081),
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: 255,
                height: 73,
                child: ElevatedButton(
                  onPressed: _predict,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFC08081),
                    foregroundColor: Color(0xFFEAE0C8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
                  ),
                  child: const Text("Predict",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                  )
                  
                )
                
              ),

              const SizedBox(height: 20),
              Text(result, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
