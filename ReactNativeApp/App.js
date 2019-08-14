import React, { Component } from 'react';
import { View, StyleSheet, ActivityIndicator } from 'react-native';

import AsyncStorage from '@react-native-community/async-storage';
import Navigation from './src/screens/Navigation/Navigation';
import SplashScreen from './src/screens/Splash/Splash';

class App extends Component {
  state = {
    checkedIsLoggedIn: false,
    isLoading: true
  }

  performTimeConsumingTask = async () => {
    return new Promise((resolve) =>
      setTimeout(
        () => {
          AsyncStorage.getItem("auth:email").then(emailFromStorage => {
            this.setState({ checkedIsLoggedIn: true });
          }).catch(err => {
            console.log(err.message);
          });
          resolve('result');
        }, 2000)
    );
  };

  async componentDidMount() {
    const data = await this.performTimeConsumingTask();

    if (data !== null) {
      this.setState({ isLoading: false });
    }
  }

  render() {
    if (this.state.isLoading) {
      return <SplashScreen></SplashScreen>;
    }

    if (this.state.checkedIsLoggedIn) {
      return <Navigation></Navigation>;
    } else {
      return (
        <View style={styles.container}>
          <ActivityIndicator size="large"></ActivityIndicator>
        </View>
      );
    }
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center'
  }
});

export default App;