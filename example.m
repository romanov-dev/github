- (IBAction)messageItself_translateTextAction:(id)sender {
    
    
    _messageItself_translateIndicator.hidden = NO;
    
    if ([current_text isEqualToString:_messageItselfText.text]) {
        
        if ([translatedText isEqualToString:@"PRTranslatedTextNone"]) {
            
            [PFCloud callFunctionInBackground:@"translateText"
            withParameters:@{@"transText": current_text, @"curCountryCode": deviceLanguage}
            block:^(NSString *objects, NSError *error) {
                _messageItself_translateIndicator.hidden = YES;
                if (!error) {
                    
                    
                
                    if ([objects isEqualToString:@"PRSameLang"]) {
                        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"cantTranslateSameLang", nil) delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                        [alert show];
                        _messageItself_translateTextOutlet.backgroundColor = nil;
                        [_messageItself_translateTextOutlet setTitleColor:UIColorFromRGB(0x75A9AE) forState:UIControlStateNormal];
                        
                        
                    }
                    else{
                        translatedText = objects;
                        if ([translatedText isEqualToString:current_text]) {
                            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"cantTranslate", nil) delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                            [alert show];
                            
                            translatedText = @"PRTranslatedTextNone";
                        }
                        else{
                            [_messageItselfText setDataDetectorTypes:UIDataDetectorTypeNone];
                            _messageItselfText.text = translatedText;
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                if(current_messageType == 0){
                                    [self messageItself_construction:0];
                                }
                                else{
                                    if (current_opinionResult == 0) {
                                        [self messageItself_construction:3];
                                    }
                                    else{
                                        [self messageItself_construction:4];
                                    }
                                    
                                }
                            });

                            [_messageItselfText setDataDetectorTypes:UIDataDetectorTypeLink];
                            _messageItself_translateTextOutlet.backgroundColor = UIColorFromRGB(0x75A9AE);
                            [_messageItself_translateTextOutlet setTitleColor:UIColorFromRGB(0xeeeeee) forState:UIControlStateNormal];
                        }
                    }
                    
                
                }
                else{
                    if ([[error userInfo][@"error"] integerValue] == 400) {//cannot translate
                        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"" message:NSLocalizedString(@"cantTranslate", nil) delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                        [alert show];
                    }
                }
            }];
        }
        else{
             _messageItself_translateIndicator.hidden = YES;
            
            [_messageItselfText setDataDetectorTypes:UIDataDetectorTypeNone];
            _messageItselfText.text = translatedText;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if(current_messageType == 0){
                    [self messageItself_construction:0];
                }
                else{
                    if (current_opinionResult == 0) {
                        [self messageItself_construction:3];
                    }
                    else{
                        [self messageItself_construction:4];
                    }
                    
                }
            });

            [_messageItselfText setDataDetectorTypes:UIDataDetectorTypeLink];
            _messageItself_translateTextOutlet.backgroundColor = UIColorFromRGB(0x75A9AE);
            [_messageItself_translateTextOutlet setTitleColor:UIColorFromRGB(0xeeeeee) forState:UIControlStateNormal];
            
        }
    }
    else{
         _messageItself_translateIndicator.hidden = YES;
        
        [_messageItselfText setDataDetectorTypes:UIDataDetectorTypeNone];
        _messageItselfText.text = current_text;
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(current_messageType == 0){
                [self messageItself_construction:0];
            }
            else{
                if (current_opinionResult == 0) {
                    [self messageItself_construction:3];
                }
                else{
                    [self messageItself_construction:4];
                }
                
            }
        });
                       
        [_messageItselfText setDataDetectorTypes:UIDataDetectorTypeLink];
        _messageItself_translateTextOutlet.backgroundColor = nil;
        [_messageItself_translateTextOutlet setTitleColor:UIColorFromRGB(0x75A9AE) forState:UIControlStateNormal];
        
    }

}
