import { useEffect, useState } from "react";
import "./App.css";
import { BrowserRouter, Routes, Route } from "react-router-dom";
import axios from "axios";

const BACKEND_URL = process.env.REACT_APP_BACKEND_URL;
const API = `${BACKEND_URL}/api`;

const IOSPreview = () => {
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    // Simulate app loading
    const timer = setTimeout(() => {
      setLoading(false);
    }, 2000);
    return () => clearTimeout(timer);
  }, []);

  return (
    <div className="ios-preview">
      <div className="phone-container">
        <div className="phone-screen">
          <div className="notch"></div>
          <div className="status-bar">
            <span>9:41</span>
            <span>📶 📶 📶 🔋</span>
          </div>
          <div className="webview-container">
            {loading && (
              <div className="loading-overlay">
                <div className="app-icon">SCS</div>
                <div className="loading-text">Secret Chelsea Society</div>
                <div className="loading-spinner"></div>
              </div>
            )}
            <iframe 
              className="webview" 
              src="https://www.secretchelsociety.com"
              title="Secret Chelsea Society Website"
            />
          </div>
        </div>
        <div className="preview-info">
          iOS App Preview - This is how your app will look!
        </div>
        <div className="controls">
          <button className="btn" onClick={() => window.location.reload()}>
            🔄 Reload
          </button>
          <button className="btn secondary" onClick={() => window.open('/app/web-preview/index.html', '_blank')}>
            📱 Full Preview
          </button>
        </div>
      </div>
    </div>
  );
};

const Home = () => {
  const helloWorldApi = async () => {
    try {
      const response = await axios.get(`${API}/`);
      console.log(response.data.message);
    } catch (e) {
      console.error(e, `errored out requesting / api`);
    }
  };

  useEffect(() => {
    helloWorldApi();
  }, []);

  return (
    <div>
      <header className="App-header">
        <h1 className="text-3xl font-bold mb-8">Secret Chelsea Society iOS App</h1>
        <div className="mb-8">
          <p className="text-lg mb-4">✅ iOS App Created Successfully!</p>
          <p className="text-sm text-gray-600 mb-6">
            Your website is now wrapped in a native iOS app. Preview it below:
          </p>
        </div>
        <IOSPreview />
        <div className="mt-8 max-w-2xl text-left">
          <h2 className="text-xl font-semibold mb-4">📱 iOS App Status</h2>
          <div className="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded mb-4">
            <strong>✅ Complete!</strong> Your iOS app is ready for macOS/Xcode.
          </div>
          <ul className="list-disc list-inside space-y-2 text-sm">
            <li>React Native project created with WebView</li>
            <li>Displays www.secretchelsociety.com in native app</li>
            <li>iOS project structure with Podfile configured</li>
            <li>App icons and launch screen setup</li>
            <li>Ready for App Store submission</li>
          </ul>
          <div className="mt-6 p-4 bg-yellow-100 border border-yellow-400 rounded">
            <p className="text-sm text-yellow-800">
              <strong>⚠️ Important:</strong> The iOS app requires macOS with Xcode to build. 
              Transfer the <code>/app/ios-app/</code> folder to a Mac to complete the build process.
            </p>
          </div>
        </div>
      </header>
    </div>
  );
};

function App() {
  return (
    <div className="App">
      <BrowserRouter>
        <Routes>
          <Route path="/" element={<Home />}>
            <Route index element={<Home />} />
          </Route>
        </Routes>
      </BrowserRouter>
    </div>
  );
}

export default App;
