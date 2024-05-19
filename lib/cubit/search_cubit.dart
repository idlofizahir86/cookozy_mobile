import 'package:flutter_bloc/flutter_bloc.dart';
import '../../service/recipe_service.dart';

// Event untuk pencarian resep
abstract class SearchEvent {}

class SearchRecipes extends SearchEvent {
  final String searchTerm;

  SearchRecipes(this.searchTerm);
}

// State untuk hasil pencarian resep
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Map<String, dynamic>> searchResults;

  SearchSuccess(this.searchResults);
}

class SearchError extends SearchState {
  final String errorMessage;

  SearchError(this.errorMessage);
}

// Cubit untuk mengelola pencarian resep
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  void searchRecipes(String searchTerm) async {
    emit(SearchLoading());

    try {
      final List<Map<String, dynamic>> allRecipes = await fetchRecipes();
      final List<Map<String, dynamic>> filteredRecipes = [];

      // Log the all recipes
      print('All Recipes: $allRecipes');

      // Lakukan pencarian berdasarkan kata kunci di judul atau deskripsi resep
      for (final recipe in allRecipes) {
        final title = recipe['title'].toString().toLowerCase();
        final description = recipe['description'].toString().toLowerCase();
        if (title.contains(searchTerm.toLowerCase()) ||
            description.contains(searchTerm.toLowerCase())) {
          filteredRecipes.add(recipe);
        }
      }

      // Log the filtered recipes
      print('Filtered Recipes: $filteredRecipes');

      emit(SearchSuccess(filteredRecipes));
    } catch (e) {
      // Log the error
      print('Error during search: $e');
      emit(SearchError('Failed to search recipes. Please try again later.'));
    }
  }
}
