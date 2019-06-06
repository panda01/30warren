function createDocument(html) {
  let doc;

  if (/<(html|body)/i.test(html)) {
    doc = document.documentElement.cloneNode();
    doc.innerHTML = html;
  } else {
    doc = document.documentElement.cloneNode(true);
    doc.querySelector('body').innerHTML = html;
  }

  doc.head = doc.querySelector('head');
  doc.body = doc.querySelector('body');

  return doc;
}

module.exports = createDocument;
