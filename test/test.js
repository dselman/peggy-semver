const parser = require('../parser');
const fs = require('fs');
const assert = require('assert');
const semver = require('semver');

describe('semver parser', function () {
  describe('#valid', function () {
    it(`should parse all valid semvers`, function () {
      const lines = fs.readFileSync('./test/semver-valid.txt', 'utf-8').split(/\r?\n/);
      lines.forEach(line => {
        try {
          assert.strictEqual(semver.valid(line, false) !== null, true );
          parser.parse(line);
        }
        catch (err) {
          throw new Error(`Failed to parse ${line} with error: ${err}`);
        }
      });
    });
  });
  describe('#invalid', function () {
    it(`should not parse invalid semvers`, function () {
      const lines = fs.readFileSync('./test/semver-invalid.txt', 'utf-8').split(/\r?\n/);
      lines.forEach(line => {
        assert.strictEqual(semver.valid(line, false), null );
        assert.throws(() => parser.parse(line), /SyntaxError/, line);
      });
    });
  });
});
