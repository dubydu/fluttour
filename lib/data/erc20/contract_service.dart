import 'dart:async';
import 'package:web3dart/web3dart.dart';

typedef TransferEvent = void Function(
    EthereumAddress from,
    EthereumAddress to,
    BigInt value);

typedef TransferValue = void Function(
    double? value);

enum EventABIType {
  Transfer,
  Approval,
}

abstract class ContractServiceDelegate {
  Future<List<dynamic>> getAmountsOut(List<dynamic> from);
  Future<List<dynamic>> getAmountsIn(List<dynamic> from);
  Future<void> dispose();
  StreamSubscription listenEvent(TransferEvent onTransfer, EventABIType type);
}

class ContractService implements ContractServiceDelegate {
  ContractService(this.client, this.contract);
  ContractService.origin(this.client);

  late final Web3Client client;
  late DeployedContract contract;

  /// Events ABI
  ContractEvent _transferEvent() => contract.event('Transfer');
  ContractEvent _approvalEvent() => contract.event('Approval');
  /// Function ABI
  ContractFunction _getAmountsOutFunction() => contract.function('getAmountsOut');
  ContractFunction _getAmountsInFunction() => contract.function('getAmountsIn');

  @override
  Future<List<dynamic>> getAmountsOut(List<dynamic> from) async {
    final List<dynamic> response = await client.call(
      contract: contract,
      function: _getAmountsOutFunction(),
      params: from,
    );
    final List<dynamic> convertResponse = response.first as List<dynamic>;
    return convertResponse;
  }

  @override
  Future<List> getAmountsIn(List<dynamic> from) async {
    final List<dynamic> response = await client.call(
      contract: contract,
      function: _getAmountsInFunction(),
      params: from,
    );
    final List<dynamic> convertResponse = response.first as List<dynamic>;
    return convertResponse;
  }

  @override
  StreamSubscription listenEvent(TransferEvent onTransfer, EventABIType type) {
    var events = client.events(FilterOptions.events(
      contract: contract,
      event: getEvent(type),
    ));

    return events.listen((FilterEvent event) {
      if (event.topics == null || event.data == null) {
        return;
      }
      final decoded = _transferEvent().decodeResults(event.topics!, event.data!);
      final from = decoded[0] as EthereumAddress;
      final to = decoded[1] as EthereumAddress;
      final value = decoded[2] as BigInt;
      onTransfer(from, to, value);
    });
  }

  ContractEvent getEvent(EventABIType type) {
    switch (type) {
      case EventABIType.Approval:
        return _approvalEvent();
      default:
        return _transferEvent();
    }
  }

  @override
  Future<void> dispose() async {
    await client.dispose();
  }
}