import 'package:bloc/bloc.dart';

import 'chat_state.dart';


class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
}
