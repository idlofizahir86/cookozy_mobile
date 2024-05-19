import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/search_cubit.dart';
import '../../shared/theme.dart';
import '../widgets/custom_search_bar.dart';
import '../widgets/filtered_recipe_list.dart';
import '../widgets/top_section_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchHistory = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: BlocProvider(
          create: (context) => SearchCubit(),
          child: Stack(
            children: [
              const TopSectionWidget(
                title: "Pencarian",
                back: true,
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 50,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomSearchBar(
                          controller: _searchController,
                          onSubmitted: (String searchTerm) {
                            if (searchTerm.isNotEmpty) {
                              print('Search term submitted: $searchTerm');
                              context
                                  .read<SearchCubit>()
                                  .searchRecipes(searchTerm);
                            } else {
                              print('Search term is empty.');
                              // Tampilkan pesan atau lakukan tindakan lainnya untuk teks pencarian kosong.
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      BlocBuilder<SearchCubit, SearchState>(
                        builder: (context, state) {
                          if (state is SearchLoading) {
                            print('Search is loading...');
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (state is SearchSuccess) {
                            print(
                                'Search succeeded with results: ${state.searchResults}');
                            if (state.searchResults.isEmpty) {
                              print('No results found.');
                              return const Center(
                                  child: Text("No results found."));
                            }
                            return FilteredRecipeList(
                              recipes: state.searchResults,
                            );
                          } else if (state is SearchError) {
                            print('Search error: ${state.errorMessage}');
                            return Center(child: Text(state.errorMessage));
                          } else {
                            print('Search state is initial.');
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
