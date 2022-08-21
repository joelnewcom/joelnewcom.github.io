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