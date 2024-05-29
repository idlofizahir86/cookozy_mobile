import 'package:cookozy_mobile/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../shared/theme.dart';
import '../../widgets/custom_search_bar.dart';
import '../../widgets/top_section_widget.dart';
import '../../widgets/recipe_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchHistory = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      if (_searchController.text.isEmpty && isSearching) {
        setState(() {
          isSearching = false;
        });
      }
    });
    context.read<SearchCubit>().fetchAllRecipes();
    loadSearchHistory();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadSearchHistory();
  }

  @override
  void dispose() {
    isSearching = false;
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadSearchHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        searchHistory = prefs.getStringList('searchHistory') ?? [];
        // Debug log
      });
    } catch (e) {}
  }

  Future<void> saveSearchHistory() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('searchHistory', searchHistory);
      // Debug log
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSearching) {
          context.read<SearchCubit>().fetchAllRecipes();
          loadSearchHistory();

          setState(() {
            isSearching = false;
          });
          return false;
        }
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kWhiteColor,
          body: Stack(
            children: [
              const TopSectionWidget(
                title: "Pencarian",
                back: true,
              ),
              Container(
                margin: const EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomSearchBar(
                          controller: _searchController,
                          onSubmitted: (String searchTerm) {
                            context
                                .read<SearchCubit>()
                                .searchRecipes(searchTerm);
                            addSearchHistory(searchTerm);
                            setState(() {
                              isSearching = true;
                            });
                          },
                        ),
                      ),
                      if (!isSearching && searchHistory.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pencarian Sebelumnya",
                                style: semiBoldTextStyle.copyWith(
                                  fontSize: 16,
                                  color: kBlackColor,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: buildSearchHistoryItems(),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      if (!isSearching)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Pencarian Terpopuler",
                                style: semiBoldTextStyle.copyWith(
                                  fontSize: 16,
                                  color: kBlackColor,
                                ),
                              ),
                              BlocBuilder<SearchCubit, SearchState>(
                                builder: (context, state) {
                                  if (state is SearchPopuler) {
                                    List recipes = state.searchPopuler;
                                    recipes.shuffle();
                                    List popularRecipes =
                                        recipes.take(6).toList();

                                    return LayoutBuilder(
                                      builder: (context, constraints) {
                                        int crossAxisCount = 2;
                                        if (constraints.maxWidth >= 1200) {
                                          crossAxisCount = 4;
                                        } else if (constraints.maxWidth >=
                                            900) {
                                          crossAxisCount = 3;
                                        } else if (constraints.maxWidth >=
                                            600) {
                                          crossAxisCount = 2;
                                        }

                                        return GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: crossAxisCount,
                                            childAspectRatio: 2 / 3,
                                          ),
                                          itemCount: popularRecipes.length,
                                          itemBuilder: (context, index) {
                                            final recipe =
                                                popularRecipes[index];
                                            return RecipeCard(
                                              marginRight: 5,
                                              marginLeft: 5,
                                              recipe: recipe,
                                            );
                                          },
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      if (isSearching)
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              BlocBuilder<SearchCubit, SearchState>(
                                builder: (context, state) {
                                  if (state is SearchSuccess) {
                                    return LayoutBuilder(
                                      builder: (context, constraints) {
                                        int crossAxisCount = 2;
                                        if (constraints.maxWidth >= 1200) {
                                          crossAxisCount = 4;
                                        } else if (constraints.maxWidth >=
                                            900) {
                                          crossAxisCount = 3;
                                        } else if (constraints.maxWidth >=
                                            600) {
                                          crossAxisCount = 2;
                                        }

                                        return GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: crossAxisCount,
                                            childAspectRatio: 2 / 3,
                                          ),
                                          itemCount: state.searchResults.length,
                                          itemBuilder: (context, index) {
                                            final recipe =
                                                state.searchResults[index];
                                            return RecipeCard(
                                              marginRight: 5,
                                              marginLeft: 5,
                                              recipe: recipe,
                                            );
                                          },
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                        );
                                      },
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(height: 50),
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

  List<Widget> buildSearchHistoryItems() {
    return searchHistory.map((keyword) {
      return IntrinsicWidth(
        child: Container(
          height: 40,
          padding: const EdgeInsets.only(left: 15, right: 10),
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(225, 229, 221, 191),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  keyword,
                  style: boldTextStyle.copyWith(
                    fontSize: 14,
                    color: kSecondaryColor,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 7),
              GestureDetector(
                onTap: () {
                  removeSearchHistory(keyword);
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/icon_close.png"),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  void removeSearchHistory(String keyword) {
    setState(() {
      searchHistory.remove(keyword);
    });
    saveSearchHistory();
  }

  void addSearchHistory(String keyword) {
    if (!searchHistory.contains(keyword)) {
      setState(() {
        searchHistory.insert(0, keyword);
        if (searchHistory.length > 5) {
          searchHistory.removeLast();
        }
      });
      saveSearchHistory();
    }
  }
}
