import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mvi_flutter_example/networking/networking_response.dart';

class ErrorHandlerTransformer
    extends Converter<Response<dynamic>, NetworkingResponse> {
  @override
  Sink<Response> startChunkedConversion(Sink<NetworkingResponse> sink) {
    return ErrorHandlerConversionSink(sink, this);
  }

  @override
  NetworkingResponse convert(Response input) {
    switch (input.statusCode) {
      case 200:
        return NetworkingResponse(data: input.data);
      case 201:
        return NetworkingResponse(data: input.data);
      case 404:
        return NetworkingResponse(exception: Exception("No people found"));
      case 500:
        return NetworkingResponse(exception: Exception("Server error"));
      default:
        return NetworkingResponse(
            exception: Exception("Something bad happened, sorry =/"));
    }
  }
}

class ErrorHandlerConversionSink
    extends ChunkedConversionSink<Response<dynamic>> {
  EventSink<NetworkingResponse> sink;
  Converter<Response<dynamic>, NetworkingResponse> converter;

  ErrorHandlerConversionSink(Sink<NetworkingResponse> sink,
      Converter<Response<dynamic>, NetworkingResponse> converter) {
    this.sink = sink;
    this.converter = converter;
  }

  @override
  void add(Response<dynamic> chunk) {
    sink.add(converter.convert(chunk));
  }

  @override
  void close() {
    sink.close();
  }
}
