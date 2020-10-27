import 'package:lister/models/category.dart';
import 'package:lister/repositories/repository.dart';

class CategoryService {
  Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  // cria os dados
  saveCategory(Category category) async {
    return await _repository.insertData('categories', category.categoryMap());
  }

  // ler os dados da table
  readCategories() async { // passar o userid
    return await _repository.readData('categories');
  }

  // le os dados na table pelo id
  readCategoryById(categoryId) async {
    return await _repository.readDataById('categories', categoryId);
  }

  // atualiza os dados da table
  updateCategory(Category category) async {
    return await _repository.updateData('categories', category.categoryMap());
  }

  // delete data da table
  deleteCategory(categoryId) async {
    return await _repository.deleteData('categories', categoryId);
  }
}
