
/* 
Copyright (C) 2000 Ferdinando Ametrano, Luigi Ballabio, Adolfo Benin, Marco Marchioro
See the file LICENSE.TXT for information on usage and distribution
Contact ferdinando@ametrano.net if LICENSE.TXT was not distributed with this file
*/

#ifndef quantlib_string_converters_h
#define quantlib_string_converters_h

#include "qldefines.h"
#include <string>
#include <cctype>
#include <algorithm>
#include <functional>

namespace QuantLib {

	void ConvertToLowercase(std::string& str);
	void ConvertToUppercase(std::string& str);
	
	// helper classes
	
	namespace CharConverters {
	
		class LowercaseConverter : public std::unary_function<char,char> {
		  public:
			operator()(char c) { return char(QL_TOLOWER(c)); }
		};
		
		class UppercaseConverter : public std::unary_function<char,char> {
		  public:
			operator()(char c) { return char(QL_TOUPPER(c)); }
		};
	
	}
	
	// inline definitions
	
	inline void ConvertToLowercase(std::string& str) {
		std::transform(str.begin(),str.end(),str.begin(),CharConverters::LowercaseConverter());
	}
	
	inline void ConvertToUppercase(std::string& str) {
		std::transform(str.begin(),str.end(),str.begin(),CharConverters::UppercaseConverter());
	}

}


#endif
