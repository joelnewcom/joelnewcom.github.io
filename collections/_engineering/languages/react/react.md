---
layout: single
---

# React-scripts
If you have a username with spaces on windows, you will have a hardtime to setup a react-script project.

run ```npm config edit```
uncomment the entry for "cache", and remove all the spaces from the folder name, then you take the first 6 characters of the folder name and postfix it with ~1. 
Officially, you should also uppercase it.

```C:\Users\Gijs van Dam\AppData\Roaming\npm-cache```
the path with the short folder name is:
```C:\Users\GIJSVA~1\AppData\Roaming\npm-cache```

# Conditional rendering
```
class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      hidden: false
    };
  }
  render() {
    return (
      <div className="App">
        {!this.state.hidden && <SpinnerBasicExample />}
        <h2>Start editing to see some magic happen!</h2>
      </div>
    );
  }
}

const rootElement = document.getElementById("root");
ReactDOM.render(<App />, rootElement);
```

# Redux and React State
When using Redux you sometimes don't want to have all the boilerplate code for a simple UI state. According to Redux its
fine to use React state and Redux at the same time:
https://redux.js.org/faq/organizing-state#do-i-have-to-put-all-my-state-into-redux-should-i-ever-use-reacts-setstate

As soon as the state is used in multiple parts of the apps, its time to move it to Redux state.


# Arrow functions
https://stackoverflow.com/questions/47587470/whats-difference-between-two-ways-of-defining-method-on-react-class-in-es6

When using arrow functions, we can use the "this" of the enclosing context.   
```
bar = () => {
    console.log("bar")
    this.context.of.caller
}
```

If you want to use the oldschool method declaration like:

```
baz() {
    console.log("baz")
    this.context.within.method
}
```

You would need to "bind" this method to your context.  