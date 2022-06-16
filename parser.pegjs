/*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/**
 * SemVer.org v2
 * https://semver.org/spec/v2.0.0.html
 */
 {
   function checkNumber() {
       const value = text();
      if(value.startsWith('0') && value.length > 1 && !isNaN(value)) {
        error("Numeric identifier cannot have a leading zero")
      }
      return value;
   }
 }

valid_semver = version_core ! ("+" build / "-" pre_release)
                 / version_core "+" build
                 / version_core "-" pre_release ! "+"
                 / version_core "-" pre_release "+" build

version_core = major "." minor "." patch

major = numeric_identifier

minor = numeric_identifier

patch = numeric_identifier

pre_release = dot_separated_pre_release_identifiers

dot_separated_pre_release_identifiers = head:pre_release_identifier tail:("." @pre_release_identifier)* { return [head, ...tail]; }

pre_release_identifier = alphanumeric_identifier
                          / positive_digits

build = dot_separated_build_identifiers

dot_separated_build_identifiers = head:build_identifier tail:("." @build_identifier)* { return [head, ...tail]; }

build_identifier = alphanumeric_identifier
                     / digits

alphanumeric_identifier = non_digit !identifier_characters
                            / non_digit identifier_characters
                            / identifier_characters 
{
  return checkNumber();
}

numeric_identifier = [0-9]+
{
  return checkNumber();
}

identifier_characters = [0-9A-Za-z-]+

digits = digit+
positive_digits = head:positive_digit tail:(@digit)* { return [head, ...tail]; }

non_digit = [A-Za-z-]
digit = [0-9]
positive_digit = [1-9]
letter = [A-Za-z]