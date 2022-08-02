import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResponseHandler {
  static String? of(http.Response response, {BuildContext? context}) {
    debugPrint(response.request?.url.toString());
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body;
    } else {
      switch (response.statusCode) {
        case 401: // Request Unauthorized.
          //case 403: // Request Forbidden.
          /*logout().then((status) {
            if (status && context!=null) {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(LandingPage.tag, (route) => false);
            }
          });*/
          return null;
        default:
          /*if (context != null) {
            try {
              if (json.decode(response.body)['message'] != 'Invalid token')
                showErrorSnackbar(
                    context, json.decode(response.body)['message']);
            } catch (e) {
              final message = (kDebugMode && response.statusCode == 404)
                  ? 'Seems like we forgot to deploy ${response.request.url}'
                  : 'Oops! Seems like something is missing';
              showErrorSnackbar(context, message);
            }
          }*/
          return null;
      }
    }
  }

}
