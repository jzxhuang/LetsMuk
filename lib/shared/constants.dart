import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  contentPadding: EdgeInsets.all(12.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0),
  ),
);

const API_URL = "letsmuk-api.herokuapp.com";
const AGORA_APP_ID = '662e33a3f69a48bfa6dffda7a482d979';
// Temporary Agora token (valid only for a single channel)
// https://docs.agora.io/en/Video/run_demo_live_flutter?platform=Flutter
const AGORA_TEMP_TOKEN =
    '006662e33a3f69a48bfa6dffda7a482d979IAC3yaNRacNn9AUcgxReBkAdloOcZyFO+ovLRyBSPH48s2/A5uMAAAAAEAAdwi3RZuxEYAEAAQBl7ERg';
const AGORA_CHANNEL_NAME = 'tempChannel';
