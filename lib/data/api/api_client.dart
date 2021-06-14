import 'package:fluttour/app_define/app_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLAPIClient {
  GraphQLClient _client() {
    final HttpLink _httpLink = HttpLink(
      AppConfig.shared.env!.graphQLEndPoint,
    );

    /// Auth link
    final AuthLink _authLink = AuthLink(
      getToken: () => 'Bearer <YOU_PERSONAL_ACCESS_TOKEN>',
    );

    /// Link
    final Link _link = _authLink.concat(_httpLink);

    /// Policies
    /// - Remove cache
    final policies = Policies(
      fetch: FetchPolicy.networkOnly,
    );

    return GraphQLClient(
      cache: GraphQLCache(
        store: HiveStore(),
      ),
      link: _link,
      defaultPolicies: DefaultPolicies(
        watchQuery: policies,
        query: policies,
        mutate: policies,
      ),
    );
  }

  Future<QueryResult> execute(String queries) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: gql(queries),
      pollInterval: Duration(seconds: 15),
      fetchResults: true,
    );
    return await _client().query(_options);
  }
}