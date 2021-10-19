import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signin_page/pages/authentication.dart';
import 'package:signin_page/pages/entries.dart';

class ApplicationState extends ChangeNotifier{

        ApplicationState(){
          init();
        }

        Future<void> init() async{
          await Firebase.initializeApp();

          FirebaseAuth.instance.userChanges().listen((user) {
            if(user != null)
            {
              _loginState = ApplicationLoginState.loggedIn;
              _entryDataSubscription = FirebaseFirestore.instance
                  .collection('Entries')
                  .orderBy('timestamp', descending: true)
                  //.limit(3)
                  .snapshots()
                  .listen((snapshot) {
                    _entryDatas = [];
                    for( final document in snapshot.docs) {
                        _entryDatas.add(
                          EntryData(
                              dataname: document.data()['name'] as String,
                              dataentry: document.data()['entry'] as String,
                              datatime: document.data()['timeLog'] as String,
                          ),
                        );
                    }
                    notifyListeners();
              });
            }
            else
            {
              _loginState = ApplicationLoginState.loggedOut;
              _entryDatas = [];
              _entryDataSubscription?.cancel();
            }
            notifyListeners();
          });
        }

        ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
        ApplicationLoginState get loginState => _loginState;

        String? _email;
        String? get email => _email;

        StreamSubscription<QuerySnapshot>? _entryDataSubscription;
        List<EntryData> _entryDatas=[];
        List<EntryData> get entryDatas => _entryDatas;



        void startLoginFlow() {
          _loginState = ApplicationLoginState.emailAddress;
          notifyListeners();
        }

        void verifyEmail(
            String email,
            void Function(FirebaseAuthException e) errorCallback,
            )
        async
        {
          try
          {
            var methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
            if(methods.contains('password'))
            {
              _loginState = ApplicationLoginState.password;
            }
            else
            {
              _loginState = ApplicationLoginState.register;
            }
            _email = email;
            notifyListeners();
          }
          on FirebaseAuthException catch (e)
          {
            errorCallback(e);
          }
        }

        void signInWithEmailAndPassword(
            String email,
            String password,
            void Function(FirebaseAuthException e) errorCallback,
            )
        async
        {
          try
          {
            await FirebaseAuth.instance.signInWithEmailAndPassword
              (
              email: email,
              password: password,
            );
          }
          on FirebaseAuthException catch(e)
          {
            errorCallback(e);
          }
        }

        void cancelRegistration() {
          _loginState = ApplicationLoginState.emailAddress;
          notifyListeners();
        }

        void registerAccount(
            String email,
            String displayName,
            String password,
            void Function(FirebaseAuthException e) errorCallback,
            )
        async
        {
          try {
            var credential = await FirebaseAuth.instance
                .createUserWithEmailAndPassword(email: email, password: password);
            await credential.user!.updateDisplayName(displayName);
          }
          on FirebaseAuthException catch (e) {
            errorCallback(e);
          }
        }

        void signOut()
        {
          FirebaseAuth.instance.signOut();
        }

        Future<DocumentReference> addToEntries (String addentry, String timelog){
          if( _loginState != ApplicationLoginState.loggedIn ) {
            throw Exception("Please Login");
          }
          return FirebaseFirestore.instance.collection('Entries').add({
            'entry' : addentry,
            'timeLog' : timelog,
            'timestamp' : DateTime.now().millisecondsSinceEpoch,
            'name' : FirebaseAuth.instance.currentUser!.displayName,
            'userId' : FirebaseAuth.instance.currentUser!.uid,
          });
        }

}

