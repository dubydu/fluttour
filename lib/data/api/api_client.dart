import 'package:fluttour/app_define/app_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLAPIClient {
  GraphQLClient _client() {
    final HttpLink _httpLink = HttpLink(
      AppConfig.shared.env!.graphQLEndPoint,
    );

    /// Auth link
    final AuthLink _authLink = AuthLink(
      getToken: () => 'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImdjbXMtbWFpbi1wcm9kdWN0aW9uIn0.eyJ2ZXJzaW9uIjozLCJpYXQiOjE2MjMyOTAwNzIsImF1ZCI6WyJodHRwczovL2FwaS1hcC1ub3J0aGVhc3QtMS5ncmFwaGNtcy5jb20vdjIvY2twcGhqd2hjejFibzAxeHNiZGt4N3JqeC9tYXN0ZXIiLCJodHRwczovL21hbmFnZW1lbnQtbmV4dC5ncmFwaGNtcy5jb20iXSwiaXNzIjoiaHR0cHM6Ly9tYW5hZ2VtZW50LmdyYXBoY21zLmNvbS8iLCJzdWIiOiJkOWMyN2FlYS03M2VjLTQ3ZWItYjJmNC0xZDczMTA1ZTE3YWEiLCJqdGkiOiJja3BxOHp3M2tveG9lMDF6NGMyMHZlZ2R1In0.JOWJb8xvIp6pm1JQKR35srLqIHmx2iQarlw7GI4vPVP4brWAKTi7J0urUb__aXDNjHIOSTZlNXfnJ-LV6z2DRFHF-8sIzFkNNoBaIcI01rxqMqm9VriOKFotzqXsppCQITp_69tPCSUqQFqNrU1NCIvCYWIF5NhJXKacSgSi_4rrLwl0MwZm83aUkWPd1vOl25sgC7Fg9Flxd87eJjBBNXwtJF4MOqP6zKfKXdi_VNXraffL-HBsFjUp0okBmcAn0LSa4felDEIs4-_ihCYl_1UZYT4tpqf7c-uxjU-VNpEokRMh4iB28WKC8mEVS498-BcHv7vRij3q_jZZ7ETR_aKWpfSwIRMEsgv89VMLafvAz0RAd1nFXS3OQeP57k4YuhkokIUzaDDRVQjSFHcMa8nhydQ0ZrWjvmezbSWZYlVU5PrbABCCbEzARCgR53NV2hDJODNX-o1buJC1fvFR0GXHetmylceShO4e-ZGtb2vEOQqwVfCPm2qS9eZL6l3gle7flzl0hj8aiPp7OWTaht4_kqmAUKEDF-J5PuooKF5XqjC68hkOmVtlti7tVLNAECcUuUzojssqac7YjmIzJ99aaddpbxTHO0hlW7fwPKEtvsiSvnrQEDNtNdpx--NEHrZXbFMc0LwrqEkl3UUQHQ4aHGYI_ZPRTz3iv9zMlWw',
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

  /// Start query
  Future<QueryResult> query(String queries) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: gql(queries),
      pollInterval: Duration(seconds: 15),
      fetchResults: true,
    );
    return await _client().query(_options);
  }

  /// Start mutation
  Future<QueryResult> mutation(String queries) async {
    final MutationOptions _options = MutationOptions(
      document: gql(queries),
    );
    return await _client().mutate(_options);
  }

  /// Handle exception
  void handleException(QueryResult queryResult) {
    if (queryResult.exception.linkException is HttpLinkServerException) {
      HttpLinkServerException httpLink = queryResult.exception.linkException as HttpLinkServerException;
      if (httpLink.parsedResponse?.errors?.isNotEmpty == true) {
        print("::: GraphQL error message log: ${httpLink.parsedResponse?.errors?.first.message}");
      }
      return;
    }
    if (queryResult.exception.linkException is NetworkException) {
      NetworkException networkException = queryResult.exception.linkException as NetworkException;
      print("::: GraphQL error message log: ${networkException.message}");
      return;
    }
  }
}