import React, { Component } from 'react';
import {
  View,
  Text,
  StyleSheet,
  Dimensions,
  Keyboard,
  TouchableWithoutFeedback,
  ActivityIndicator,
  ScrollView,
} from 'react-native';
import { connect } from "react-redux";

import DefaultInput from "../../components/UI/DefaultInput/DefaultInput";
import ButtonWithBackground from "../../components/UI/ButtonWithBackground/ButtonWithBackground";
import validate from "../../utility/validation";
import * as actions from '../../store/actions/index';
import Icon from 'react-native-vector-icons/Ionicons';

class AuthScreen extends Component {
  state = {
    viewMode: Dimensions.get("window").height > 500 ? "portrait" : "landscape",
    isSignUp: false,
    controls: {
      email: {
        value: "",
        valid: false,
        validationRules: {
          isEmail: true
        },
        touched: false
      },
      password: {
        value: "",
        valid: false,
        validationRules: {
          minLength: 6
        },
        touched: false,
        icon: "md-eye-off",
        show: false
      },
      confirmPassword: {
        value: "",
        valid: false,
        validationRules: {
          equalTo: "password"
        },
        touched: false,
        icon: "md-eye-off",
        show: false
      }
    }
  };

  constructor(props) {
    super(props);
    Dimensions.addEventListener("change", this.updateStyles);
  }

  componentWillUnmount() {
    Dimensions.removeEventListener("change", this.updateStyles);
  }

  switchAuthModeHandler = () => {
    this.setState(prevState => {
      return {
        isSignUp: prevState.isSignUp ? false : true
      };
    });
  };

  updateStyles = dims => {
    this.setState({
      viewMode: dims.window.height > 500 ? "portrait" : "landscape"
    });
  };

  authHandler = () => {
    this.props.onAuth(this.state.controls.email.value, this.state.controls.password.value, this.state.isSignUp);
  };

  updateInputState = (key, value) => {
    let connectedValue = {};
    if (this.state.controls[key].validationRules.equalTo) {
      const equalControl = this.state.controls[key].validationRules.equalTo;
      const equalValue = this.state.controls[equalControl].value;
      connectedValue = {
        ...connectedValue,
        equalTo: equalValue
      };
    }
    if (key === "password") {
      connectedValue = {
        ...connectedValue,
        equalTo: value
      };
    }
    this.setState(prevState => {
      return {
        controls: {
          ...prevState.controls,
          confirmPassword: {
            ...prevState.controls.confirmPassword,
            valid:
              key === "password"
                ? validate(
                  prevState.controls.confirmPassword.value,
                  prevState.controls.confirmPassword.validationRules,
                  connectedValue
                )
                : prevState.controls.confirmPassword.valid
          },
          [key]: {
            ...prevState.controls[key],
            value: value,
            valid: validate(
              value,
              prevState.controls[key].validationRules,
              connectedValue
            ),
            touched: true
          }
        }
      };
    });
  };

  changeIcon = (key) => {
    this.setState(prevState => {
      return {
        controls: {
          ...prevState.controls,
          [key]: {
            ...prevState.controls[key],
            icon: prevState.controls[key].icon === "md-eye" ? "md-eye-off" : "md-eye",
            show: !prevState.controls[key].show
          }
        }
      };
    });
  };

  render() {
    let headingText = null;
    let confirmPasswordControl = null;
    let submitButton = (
      <ButtonWithBackground
        color="#29aaf4" onPress={this.authHandler}
        disabled={
          (!this.state.controls.confirmPassword.valid &&
            this.state.isSignUp) ||
          !this.state.controls.email.valid ||
          !this.state.controls.password.valid
        }>Potvrdi</ButtonWithBackground>
    );

    if (this.state.viewMode === "portrait") {
      headingText = <Text style={styles.headingText}>{this.state.isSignUp ? 'Registracija' : 'Prijava'}</Text>;
    }

    if (this.state.isSignUp) {
      confirmPasswordControl = (
        <View
          style={this.state.viewMode === "portrait" ? styles.portraitPasswordWrapper : styles.landscapePasswordWrapper}>
          <DefaultInput
            placeholder="Potvrda lozinke"
            style={styles.input}
            value={this.state.controls.confirmPassword.value}
            onChangeText={val => this.updateInputState("confirmPassword", val)}
            valid={this.state.controls.confirmPassword.valid}
            touched={this.state.controls.confirmPassword.touched}
            secureTextEntry={!this.state.controls.confirmPassword.show} />
          <Icon name={this.state.controls.confirmPassword.icon} size={25} style={styles.showPasswordIcon}
            onPress={() => this.changeIcon('confirmPassword')}></Icon>
        </View>
      );
    }

    if (this.props.isLoading) {
      submitButton = <ActivityIndicator />;
    }

    return (
      <ScrollView keyboardShouldPersistTaps={'handled'}>
        <View style={styles.container}>
          {headingText}
          <ButtonWithBackground color="#29aaf4" onPress={this.switchAuthModeHandler}>
            Idi na {this.state.isSignUp ? "prijavu" : "registraciju"}
          </ButtonWithBackground>
          <TouchableWithoutFeedback onPress={Keyboard.dismiss}>
            <View style={styles.inputContainer}>
              <DefaultInput
                placeholder="E-mail adresa"
                style={styles.input}
                value={this.state.controls.email.value}
                onChangeText={val => this.updateInputState("email", val)}
                valid={this.state.controls.email.valid}
                touched={this.state.controls.email.touched}
                autoCapitalize="none"
                autoCorrect={false}
                keyboardType="email-address" />
              <View
                style={this.state.viewMode === "portrait" || !this.state.isSignUp
                  ? styles.portraitPasswordContainer : styles.landscapePasswordContainer}>
                <View
                  style={this.state.viewMode === "portrait" || !this.state.isSignUp
                    ? styles.portraitPasswordWrapper : styles.landscapePasswordWrapper}>
                  <DefaultInput
                    placeholder="Lozinka"
                    style={styles.input}
                    value={this.state.controls.password.value}
                    onChangeText={val => this.updateInputState("password", val)}
                    valid={this.state.controls.password.valid}
                    touched={this.state.controls.password.touched}
                    secureTextEntry={!this.state.controls.password.show} />
                  <Icon name={this.state.controls.password.icon} size={25} style={styles.showPasswordIcon}
                    onPress={() => this.changeIcon('password')}></Icon>
                </View>
                {confirmPasswordControl}
              </View>
            </View>
          </TouchableWithoutFeedback>
          {submitButton}
        </View>
      </ScrollView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center"
  },
  backgroundImage: {
    width: "100%",
    flex: 1
  },
  inputContainer: {
    width: "80%"
  },
  headingText: {
    fontSize: 24,
    fontWeight: 'bold',
    paddingVertical: '5%'
  },
  input: {
    backgroundColor: "#eee",
    borderColor: "#bbb"
  },
  landscapePasswordContainer: {
    flexDirection: "row",
    justifyContent: "space-between"
  },
  portraitPasswordContainer: {
    flexDirection: "column",
    justifyContent: "flex-start"
  },
  landscapePasswordWrapper: {
    width: "45%",
    flexDirection: 'row'
  },
  portraitPasswordWrapper: {
    width: "100%",
    flexDirection: 'row'
  },
  showPasswordIcon: {
    position: 'absolute',
    top: 16,
    right: 5
  }
});

const mapStateToProps = state => {
  return {
    isLoading: state.auth.loading,
    userId: state.auth.userId
  };
};

const mapDispatchToProps = dispatch => {
  return {
    onAuth: (email, password, isSignUp) => dispatch(actions.auth(email, password, isSignUp)),
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(AuthScreen);
