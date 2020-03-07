import 'package:flutter/material.dart';
import 'package:marcador_truco/models/player.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(padding: EdgeInsets.all(3.0), child: _buildPlayerBoard()),
    );
  }

  var _playerOne = Player(name: "Nós");
  var _playerTwo = Player(name: "Eles");

  Widget _buildAppBar() {
    return AppBar(
      title: Text('Marcador de Pontos (Truco!)'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            _showAlertDialog(
                tittle: 'Reiniciar',
                content: 'Tem certeza que deseja reiniciar a partida?',
                onConfirm: () {
                  setState(() {
                    _playerOne.score = 0;
                    _playerTwo.score = 0;
                    _playerOne.name = "Nós";
                    _playerTwo.name = "Eles";
                  });
                });
          },
        )
      ],
    );
  }
  
  
  void _showAlertDialog(
      {String tittle, String content, Function onCancel, Function onConfirm}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tittle),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Cancelar',
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () {
                  if (onCancel != null) onCancel();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(
                  'Confirmar',
                  style: TextStyle(fontSize: 17),
                ),
                onPressed: () {
                  if (onConfirm != null) onConfirm();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showAlertDialog2({String tittle, Function onConfirm, String content}) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(tittle),
            content: Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (onConfirm != null) onConfirm();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void onCancel() {}

  Widget _buildPlayerBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Alterar Nome',
                      style: TextStyle(fontSize: 24),
                    ),
                    content: TextField(
                      autofocus: true,
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Digite um novo nome',
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'Cancelar',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          if (onCancel != null) onCancel();
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'Ok',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          if (_nameController.text.isEmpty) {
                            return _showAlertDialog2(
                              tittle: 'Campo precisa ser preenchido!',
                              content: "",
                            );
                          } else
                            setState(() {
                              _playerOne.name = _nameController.value.text;
                            });

                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
          child: _buildBoard(player: _playerOne),
        ),
        GestureDetector(
          onTap: () {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Alterar Nome',
                      style: TextStyle(fontSize: 24),
                    ),
                    content: TextFormField(
                      autofocus: true,
                      controller: _nameController,
                      decoration:
                          InputDecoration(hintText: 'Digite um novo nome'),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text(
                          'Cancelar',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          if (onCancel != null) onCancel();
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'Ok',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          if (_nameController.text.isEmpty) {
                            return _showAlertDialog2(
                              tittle: 'Campo precisa ser preenchido!',
                              content: "",
                            );
                          } else
                          
                            setState(() {
                              _playerTwo.name = _nameController.value.text;
                            });

                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                });
          },
          child: _buildBoard(player: _playerTwo),
        ),
      ],
    );
  }

  Widget _buildBoard({Player player}) {
    return Column(
      children: <Widget>[
        Container(padding: EdgeInsets.all(26.0)),
        _showPlayerName(name: player.name),
        _showPlayerScore(score: player.score),
        Container(padding: EdgeInsets.all(19.5)),
        _showPlayerVictories(victories: player.victories),
        Container(padding: EdgeInsets.all(19.5)),
        _showPlayerButtons(player: player)
      ],
    );
  }

  Widget _buildRoundedButton({String text, Color color, Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: ClipOval(
        child: Container(
          height: 52.0,
          width: 52.0,
          color: color,
          child: Center(
            child: Text(
              text ?? "",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget _showPlayerButtons({Player player}) {
    return Row(
      children: <Widget>[
      
        _buildRoundedButton(
            text: '-1',
            color: Colors.black.withOpacity(0.1),
            onTap: () {
              setState(() {
                player.score--;
                if (player.score == -1) {
                  _showAlertDialog2(
                      tittle: 'Não permitido!',
                      content: "",
                      onConfirm: () {
                        setState(() {
                          _playerOne.score = 0;
                          _playerTwo.score = 0;
                        });
                      });
                }
              });
            }),
        _buildRoundedButton(
            text: '+1',
            color: Colors.deepOrange,
            onTap: () {
              setState(() {
                player.score++;
                if (_playerOne.score == 12) {
                  _showAlertDialog(
                      tittle: 'Fim da partida, ' + _playerOne.name + ' Ganhou!',
                      content: 'Confirma vitória?',
                      onConfirm: () {
                        setState(() {
                          _playerOne.score = 0;
                          _playerTwo.score = 0;
                          player.victories++;
                        });
                      },
                      onCancel: () {
                        setState(() {
                          player.score--;
                        });
                      });
                } else if(_playerTwo.score == 12){
                  _showAlertDialog(
                    tittle: 'Fim da partida, ' + _playerTwo.name + ' Ganhou!',
                    content: 'Confirmar vitória?',
                    onConfirm: (){
                      setState(() {
                       _playerOne.score = 0;
                       _playerTwo.score = 0;
                       player.victories++; 
                      });
                    },
                    onCancel: (){
                      setState(() {
                       player.score--; 
                      });
                    }
                  );
                }
                else if (_playerOne.score == 11 && _playerTwo.score == 11) {
                  _showAlertDialog(
                    tittle: 'Mão de Ferro',
                    content: '',
                  );
                }
              });
            }),
      ],
    );
  }

  Widget _showPlayerVictories({int victories}) {
    return Text('vitorias ( $victories )',
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20.5));
  }

  Widget _showPlayerScore({int score}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 52.0),
      child: Text(
        '$score',
        style: TextStyle(fontSize: 120.0),
      ),
    );
  }

  Widget _showPlayerName({String name}) {
    return Text(
      name.toUpperCase(),
      style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
          color: Colors.deepOrange),
    );
  }
}
