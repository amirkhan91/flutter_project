import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:test_proj/to_do_app/data/datasources/task_local_data_source.dart';
import 'package:test_proj/to_do_app/data/models/task_model.dart';
import 'package:test_proj/to_do_app/data/repositories/task_repository_impl.dart';
import 'package:test_proj/to_do_app/domain/entities/task.dart';


class MockTaskLocalDataSource extends Mock implements TaskLocalDataSource {}

void main() {
  late TaskRepositoryImpl repository;
  late MockTaskLocalDataSource mockTaskLocalDataSource;

  setUp(() {
    mockTaskLocalDataSource = MockTaskLocalDataSource();
    repository = TaskRepositoryImpl(mockTaskLocalDataSource as TaskLocalDataSource);
  });

  test('should add a task to local data source', () async {
    // Arrange
    final task = Task(id: '1', title: 'Test Task', isCompleted: false);
    final taskModel = TaskModel(id: '1', title: 'Test Task', isCompleted: false);

    when(mockTaskLocalDataSource.addTask(taskModel)).thenAnswer((_) async => Future.value());

    // Act
    await repository.addTask(task);

    // Assert
    verify(mockTaskLocalDataSource.addTask(taskModel)).called(1);
  });
}
