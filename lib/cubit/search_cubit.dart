import 'package:cookozy_mobile/model/recipe_model.dart';
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

class SearchPopuler extends SearchState {
  final List<RecipeModel> searchPopuler;

  SearchPopuler(this.searchPopuler);
}

class SearchSuccess extends SearchState {
  final List<RecipeModel> searchResults;

  SearchSuccess(this.searchResults);
}

// State untuk menandakan bahwa pencarian telah selesai
class SearchDone extends SearchState {}

class SearchError extends SearchState {
  final String errorMessage;

  SearchError(this.errorMessage);
}

// Cubit untuk mengelola pencarian resep
class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial()) {
    fetchAllRecipes();
  }

  Future<void> fetchAllRecipes() async {
    try {
      final List<RecipeModel> allRecipes = await RecipeService().fetchRecipes();
      emit(SearchPopuler(allRecipes));
    } catch (e) {
      emit(SearchError('Failed to fetch recipes. Please try again later.'));
    }
  }

  void searchRecipes(String searchTerm) async {
    emit(SearchLoading());

    try {
      final List<RecipeModel> allRecipes = await RecipeService().fetchRecipes();
      final List<RecipeModel> filteredRecipes = [];

      final List<RecipeModel> verifiedRecipes =
          allRecipes.where((recipe) => recipe.verified == true).toList();

      // Lakukan pencarian berdasarkan kata kunci di judul atau deskripsi resep
      for (final recipe in verifiedRecipes) {
        final title = recipe.title.toString().toLowerCase();
        final description = recipe.description.toString().toLowerCase();
        if (title.contains(searchTerm.toLowerCase()) ||
            description.contains(searchTerm.toLowerCase())) {
          filteredRecipes.add(recipe);
        }
      }

      // Log the filtered recipes

      emit(SearchSuccess(filteredRecipes));
    } catch (e) {
      // Log the error
      emit(SearchError('Failed to search recipes. Please try again later.'));
    }
  }
}
