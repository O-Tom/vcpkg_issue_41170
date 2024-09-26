#include <Poco/Exception.h>
#include <Poco/Net/HTTPClientSession.h>
#include <Poco/Net/HTTPRequest.h>
#include <Poco/Net/HTTPResponse.h>
#include <Poco/StreamCopier.h>
#include <QCoreApplication>
#include <QDebug>
#include <QRegularExpression>
#include <QTimer>
#include <sstream>

int main(int argc, char* argv[]) {
  QCoreApplication app(argc, argv);

  // Example usage of QRegularExpression
  QString sampleText = "The quick brown fox jumps over 13 lazy dogs.";
  QRegularExpression regex("\\d+");  // Matches one or more digits
  QRegularExpressionMatchIterator it = regex.globalMatch(sampleText);

  qDebug() << "Found numbers in the text:";
  while (it.hasNext()) {
    QRegularExpressionMatch match = it.next();
    qDebug() << match.captured(0);  // Print the matched number
  }

  // Example usage of Poco for HTTP request
  try {
    Poco::Net::HTTPClientSession session("httpbin.org");
    Poco::Net::HTTPRequest request(Poco::Net::HTTPRequest::HTTP_GET, "/get");
    Poco::Net::HTTPResponse response;

    session.sendRequest(request);
    std::istream& rs = session.receiveResponse(response);

    std::ostringstream oss;
    Poco::StreamCopier::copyStream(rs, oss);
    qDebug() << "HTTP Response:" << QString::fromStdString(oss.str());
  } catch (Poco::Exception& ex) {
    qDebug() << "Poco Exception:" << QString::fromStdString(ex.displayText());
  }

  // Set up a timer to exit the application after 2 seconds
  QTimer::singleShot(2000, &app, &QCoreApplication::quit);

  return app.exec();
}
