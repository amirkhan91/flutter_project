import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_proj/to_do_app/data/repositories/task_repository.dart';
import 'package:test_proj/to_do_app/domain/entities/task.dart';
import 'package:test_proj/to_do_app/domain/usecases/add_task.dart';


class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late AddTask addTask;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    addTask = AddTask(mockTaskRepository as TaskRepository);
  });

  test('should add a task to the repository', () async {
    // Arrange
    final task = Task(id: '1', title: 'Test Task', isCompleted: false);
    when(mockTaskRepository.addTask(task)).thenAnswer((_) async => Future.value());

    // Act
    await addTask(task);

    // Assert
    verify(mockTaskRepository.addTask(task)).called(1);
  });
}