import 'package:fluttour/domain/models/ticket_model.dart';
import 'package:fluttour/data/api/api_client.dart';

class TicketRequest extends GraphQLAPIClient {
  Future<List<TicketModel>> getTickets() async {
    /// Query
    String fetchTickets = """
      query {
            tickets(orderBy: date_DESC) {
              id, race_id, ticket_status, date, tickets { type }
            }
        }
    """;
    final result = await this.execute(fetchTickets);
    if (result.hasException) {
      print("Error: failed to fetch ticket list => ${result.exception.graphqlErrors}");
      return [];
    }
    final Map<String, dynamic> data = result.data;
    print(data);
    return (data["tickets"] as List<dynamic>).map((e) => TicketModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}