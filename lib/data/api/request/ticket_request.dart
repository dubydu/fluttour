import 'package:fluttour/domain/models/ticket_model.dart';
import 'package:fluttour/data/api/api_client.dart';

class TicketRequest extends GraphQLAPIClient {
  Future<List<TicketModel>> getTickets({required int first, required int skip}) async {
    /// Query
    String fetchTickets = """
      query {
            tickets(orderBy: date_DESC, first: $first, skip: $skip) {
              id, race_id, ticket_status, date, tickets { type, purchase_count }
            }
        }
    """;
    final result = await this.execute(fetchTickets);
    if (result.hasException) {
      handleException(result);
      return [];
    }
    final Map<String, dynamic> data = result.data;
    return (data["tickets"] as List<dynamic>).map((e) => TicketModel.fromJson(e as Map<String, dynamic>)).toList();
  }
}