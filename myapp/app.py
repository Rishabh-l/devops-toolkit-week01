from http.server import SimpleHTTPRequestHandler, HTTPServer

class MyHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        html = """
        <html>
        <head><title>DevOps Toolkit App</title></head>
        <body style="font-family: Arial; text-align: center; margin-top: 50px;">
            <h1>🚀 DevOps Toolkit App is Live!</h1>
            <p>Built by Rishabh-l | CSoT IIT Delhi</p>
        </body>
        </html>
        """
        self.wfile.write(bytes(html, "utf8"))

server = HTTPServer(('127.0.0.1', 8000), MyHandler)
print("Python app is listening on http://127.0.0.1:8000...")
server.serve_forever()
